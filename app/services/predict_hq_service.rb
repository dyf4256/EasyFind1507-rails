require 'net/http'
require 'json'
require 'dotenv/load' # Ensure environment variables are loaded

class PredictHqService
  PREDICT_HQ_ENDPOINT = "https://api.predicthq.com/v1/events/".freeze
  API_KEY = ENV['PREDICT_HQ_API_KEY'] # Ensure this matches your .env file

  def self.fetch_events(country:, lat:, long:, scale:, total: 1000)
    new.fetch_events(country: country, lat: lat, long: long, scale: scale, total: total)
  end

  def fetch_events(country:, lat:, long:, scale:, total:)
    events = []
    offset = 0

    while events.size < total && offset < total
      uri = URI(PREDICT_HQ_ENDPOINT)
      params = {
        country: country,
        'location_around.origin': "#{lat},#{long}",
        'location_around.scale': "#{scale}km",
        limit: 50, # Adjust based on PredictHQ limits and your needs
        offset: offset
      }
      uri.query = URI.encode_www_form(params)

      response = api_request(uri)

      break unless response && response["results"]

      events.concat(response["results"])
      offset += response["results"].size

      puts "Fetched #{response['results'].size} events, total so far: #{events.size}"
      break if response["results"].size < 50
    end

    save_events_to_json(events) unless events.empty?
  end

  private

  def api_request(uri)
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{API_KEY}"
    request["Accept"] = "application/json"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    puts "Status Code: #{response.code}" # Check the HTTP status code
    puts "Response: #{response.body}"

    JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    # puts "API request failed: #{e.message}"
    puts "API request failed: #{e.class} - #{e.message}"
    nil
  end

  def save_events_to_json(events, file_name: 'predict_hq_events.json')
    file_path = Rails.root.join('db', file_name)
    File.open(file_path, 'w') do |file|
      file.write(JSON.pretty_generate(events))
    end
    puts "Events have been saved to #{file_path}"
  end
end
