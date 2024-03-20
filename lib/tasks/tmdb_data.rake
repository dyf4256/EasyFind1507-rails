# lib/tasks/tmdb_data.rake
namespace :tmdb do
  desc 'Fetch movies from TMDB and save to a JSON file'
  task fetch_movies: :environment do
    require 'json'

    puts 'Fetching movies from TMDB...'
    movies = TmdbService.fetch_movies

    File.open(Rails.root.join('db', 'movies_now_playing.json'), 'w') do |file|
      file.write(JSON.pretty_generate(movies))
    end

    puts 'Movies fetched and saved successfully.'
  end
end

#You can run this rake task with the command: bundle exec rake tmdb:fetch_movies
