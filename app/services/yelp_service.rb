# app/services/yelp_service.rb
require 'net/http'
require 'json'

class YelpService
  YELP_API_ENDPOINT = "https://api.yelp.com/v3/businesses/search".freeze
  API_KEY = "GgpDePZX0u4W7H-VCYr3-dh6Wj2_tjemx6sPdTTn-Y2FghENaLUOe2jd3HrpSBSbqLwAEnFnzpjFJnzfPqGT6edXlJCMNEmWGP05QM4MAtU9KndWTJTMIZnQJQX7ZXYx".freeze
  PER_PAGE = 50

  def self.save_businesses_to_json(term:, total: 1000, location: 'Montreal')
    new.save_businesses_to_json(term: term, total: total, location: location)
  end

  def save_businesses_to_json(term:, total:, location:)
    businesses = fetch_businesses(term: term, total: total, location: location)
    file_path = Rails.root.join('db', "#{term}_data.json")
    File.write(file_path, businesses.to_json)
  end

  private

  def fetch_businesses(term:, total:, location:)
    businesses = []
    offset = 0

    while businesses.size < total
      url = "#{YELP_API_ENDPOINT}?term=#{term}&location=#{location}&limit=#{PER_PAGE}&offset=#{offset}"
      response = api_request(url)
      break unless response && response["businesses"]

      # Break the loop if the number of businesses fetched is less than the per-page limit
      break if response["businesses"].size < PER_PAGE

      businesses.concat(response["businesses"])
      offset += PER_PAGE
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
