require 'net/http'
require 'uri'
require 'json'

class EventbriteService
  BASE_URI = 'https://www.eventbriteapi.com/v3'

  def initialize
    @token = ENV['EVENTBRITE_API_KEY']
  end

  def fetch_and_filter_events
    page = 1
    filtered_events = []

    loop do
      response = get("/users/me/events/?page=#{page}")
      break unless response.is_a?(Net::HTTPSuccess)

      events = JSON.parse(response.body)['events']
      events.each do |event|
        venue = fetch_venue(event['venue_id'])
        next unless venue && venue_in_montreal?(venue)

        filtered_events << {
          name: event['name']['text'],
          address: venue['address']['localized_address_display'],
          date: event['start']['local'],
          description: event['description']['text'],
          website: event['url'],
          img: event.dig('logo', 'original', 'url'),
          latitude: venue['latitude'],
          longitude: venue['longitude']
        }
      end

      page += 1
      pagination = JSON.parse(response.body)['pagination']
      break if page > pagination['page_count']
    end

    filtered_events
  end

  private

  def get(path)
    uri = URI("#{BASE_URI}#{path}")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{@token}"
    request["Content-Type"] = "application/json"

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
  end

  def fetch_venue(venue_id)
    return nil unless venue_id

    response = get("/venues/#{venue_id}")
    return nil unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end

  def venue_in_montreal?(venue)
    venue['address']['city'].casecmp?('montreal')
  end
end



# require 'net/http'
# require 'uri'
# require 'json'

# class EventbriteService
#   # Use the environment variable for the API key
#   API_KEY = ENV['EVENTBRITE_API_KEY']
#   BASE_URL = 'https://www.eventbriteapi.com/v3/'

#   def self.fetch_events(city: 'Montreal', total: 1000)
#     new.fetch_events(city: city, total: total)
#   end

#   def fetch_events(city:, total:)
#     events = []
#     page = 1
#     uri = URI("#{BASE_URL}events/search/")

#     Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
#       while events.size < total
#         uri.query = URI.encode_www_form({
#           'location.address' => city,
#           'expand' => 'venue',
#           'token' => API_KEY,
#           'page' => page
#         })
#         request = Net::HTTP::Get.new(uri)
#         request["Authorization"] = "Bearer #{API_KEY}"  # Use the Authorization header
#         response = http.request(request)

#         # Add logging here
#         puts "Request URL: #{uri}"
#         puts "Response Code: #{response.code}"

#         break unless response.is_a?(Net::HTTPSuccess)

#         body = JSON.parse(response.body)
#         events.concat(body['events'] || [])
#         page += 1
#         break if body.dig('pagination', 'page_count') == page || events.size >= total
#       end
#     end

#     events.first(total).map do |event|
#       {
#         name: event['name']['text'],
#         address: event.dig('venue', 'address', 'localized_address_display'),
#         date: event['start']['local'], # You may need to parse/format this date
#         description: event['description']['text'],
#         website: event['url'],
#         img: event.dig('logo', 'url'),
#         latitude: event.dig('venue', 'latitude'),
#         longitude: event.dig('venue', 'longitude')
#       }
#     end
#   end
# end
