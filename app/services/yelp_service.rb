require 'net/http'
require 'json'

class YelpService
  YELP_API_ENDPOINT = "https://api.yelp.com/v3/businesses/search".freeze
  API_KEY = ENV['YELP_API_KEY'].freeze
  PER_PAGE = 50

  def self.save_businesses_to_json(term:, total: 1000, location: 'Montreal')
    new.save_businesses_to_json(term: term, total: total, location: location)
  end

  def save_businesses_to_json(term:, total:, location:)
    file_path = Rails.root.join('db', "#{term.gsub(' ', '_')}_data.json")

    # Check if file exists and has enough data
    if File.exist?(file_path)
      file_data = JSON.parse(File.read(file_path))
      if file_data.size >= total
        puts "File for #{term} already exists with sufficient data."
        return
      end
    end

    businesses = fetch_businesses(term: term, total: total, location: location)
    File.write(file_path, businesses.to_json)
  end

  private

  def fetch_businesses(term:, total:, location:)
    businesses = []
    offset = 0

    while businesses.size < total && offset < total
      url = "#{YELP_API_ENDPOINT}?term=#{term}&location=#{location}&limit=#{PER_PAGE}&offset=#{offset}"
      response = api_request(url)
      break unless response && response["businesses"]

      businesses.concat(response["businesses"])
      offset += PER_PAGE

      break if response["businesses"].size < PER_PAGE
    end

    businesses.first(total)
  end

  def api_request(url)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{API_KEY}"

    response = http.request(request)
    JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    puts "Failed to fetch Yelp data: #{e.message}"
    nil
  end
end
