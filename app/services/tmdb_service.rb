# app/services/tmdb_service.rb
require 'open-uri'

class TmdbService
  TMDB_API_KEY = ENV['TMDB_API_KEY']

  def self.fetch_genres_mapping
    url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{TMDB_API_KEY}&language=en-US"
    response = JSON.parse(URI.open(url).read)
    response['genres'].each_with_object({}) do |genre, map|
      map[genre['id']] = genre['name']
    end
  end

  def self.fetch_movies
    genres_mapping = fetch_genres_mapping
    all_movies = []
    current_page = 1
    total_pages = 1
    max_movies = 1000

    while current_page <= total_pages && all_movies.size < max_movies
      url = "https://api.themoviedb.org/3/movie/now_playing?api_key=#{TMDB_API_KEY}&language=en-US&page=#{current_page}"
      response = JSON.parse(URI.open(url).read)

      remaining_movies_quota = max_movies - all_movies.size
      movies_with_genre_names = response['results'].take(remaining_movies_quota).map do |movie|
        movie['genre_names'] = movie['genre_ids'].map { |id| genres_mapping[id] }.compact.join(', ')
        movie
      end

      all_movies.concat(movies_with_genre_names)

      total_pages = response['total_pages']
      current_page += 1
    end

    all_movies
  end
end
