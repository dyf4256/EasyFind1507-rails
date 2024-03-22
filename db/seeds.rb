require 'open-uri'
require 'json'

puts "Destroying data..."
Recommendation.destroy_all
Session.destroy_all
Attraction.destroy_all
Event.destroy_all
Restaurant.destroy_all
Movie.destroy_all
User.destroy_all

puts "Seeding Users..."
User.create!(email: 'yuefei@hackers.com', password: 'hackers!', first_name: 'Yuefei', last_name: 'Dong')
User.create!(email: 'declan@hackers.com', password: 'hackers!', first_name: 'Declan', last_name: 'Schindler')
User.create!(email: 'laurent@hackers.com', password: 'hackers!', first_name: 'Laurent', last_name: 'Lefebvre')
puts "Users seeded successfully!"

# Import businesses
# def import_businesses_from_json(term)
#   puts "Importing #{term} from JSON..."
#   file_path = Rails.root.join('db', "#{term.gsub(' ', '_')}_data.json")
#   if File.exist?(file_path)
#     data = JSON.parse(File.read(file_path))
#     data.each do |item|
#       # Handle your restaurant and attraction seeding here
#     end
#     puts "#{term.capitalize} imported successfully."
#   else
#     puts "No JSON file found for #{term}."
#   end
# end

# ['restaurants', 'attractions'].each do |term|
#   import_businesses_from_json(term)
# end

# Seed Events
# puts "Seeding Events..."
# Event.create!(
#   name: 'Taylor Swift Dance Party',
#   address: 'Muzique Nightclub, 3781 Boulevard Saint-Laurent Montréal, QC H2W 1X8',
#   date: Date.parse('2024-03-16'),
#   description: "Montreal Swifties Unite!! SWIFTIES SOCIALS is back with the Biggest Taylor Swift Dance Party in MTL! Come party with 500+ Swifties who share your love for Taylor's music. Sing along, dance like nobody's watching, and create memories that will last a lifetime.",
#   website: 'https://www.eventbrite.ca/e/taylor-swift-dance-party-swifties-socials-montreal-march-16-tickets-826346463517?aff=ebdssbdestsearch',
#   img: 'taylor.jpeg'
# )
# Event.create!(
#   name: 'MONTREAL CAREER FAIR',
#   address: 'Montreal Convention Centre, 1001 Place Jean-Paul-Riopelle Montréal, QC H2Z 1H5',
#   date: Date.parse('2024-03-20'),
#   description: "Welcome to Jobs Canada Centre. Come and meet with recruiters in person, make a positive impression, and demonstrate your skills and qualifications. It doesn't matter what industry or background you have; whether you've recently graduated, are a skilled professional, or are looking for a fresh start, join Jobs Canada across the country. Expand your professional network, gain insights into the current job market, and bring your resume to interact with employers, industry professionals, and other attendees. Follow us for latest updates. We are here to help you!",
#   website: 'https://www.eventbrite.ca/e/montreal-career-fair-march-20th2024-tickets-706882463477?aff=ebdssbcitybrowse',
#   img: 'job.jpeg'
# )
# Event.create!(
#   name: 'Montreal Networking Event For Professionals',
#   address: 'Lounge h3, 340 Rue De la Gauchetière Ouest #2e étage Montréal, QC H2Z 0C3',
#   date: Date.parse('2024-03-15'),
#   description: "SUM OF FIVE Professional Networking Events stand as the pinnacle of stylish gatherings for both young professionals. Our main goal revolves around empowering our attendees by facilitating meaningful professional connections. We have an unwavering commitment that lies in fostering genuine relationships among peers, cultivating an environment where professionals can seamlessly connect and engage in a purposeful manner. We aspire to aid participants in their journey of expanding their businesses and advancing their careers by providing a platform to engage with individuals who share similar aspirations.",
#   website: 'https://www.eventbrite.ca/e/montreal-networking-event-for-professionals-lounge-h3-tickets-843030616267?aff=ebdssbdestsearch',
#   img: 'job2.jpeg'
# )
# puts "Events seeded successfully."

puts 'Seeding PredictHQ events from JSON file...'

# Path to your JSON file
file_path = Rails.root.join('db', 'predict_hq_events.json')

# Parse the JSON file
if File.exist?(file_path)
  events_data = JSON.parse(File.read(file_path))

  # Iterate over each event in your JSON file
  events_data.each do |event_data|
    # Create or update events in your database
    # Let Rails auto-increment the ID
    Event.create! do |event|
      event.name = event_data['title']
      event.address = event_data.dig('entities', 0, 'formatted_address') || 'Address not provided'
      event.date = Date.parse(event_data['start']) rescue nil # Handle date parsing gracefully
      event.description = event_data['description']
      # event.website = event_data['website'] || 'Website not provided' # Add a default value if website is not provided
      # event.img = event_data['img'] || 'Default image URL' # Add a default image URL if not provided
      event.latitude = event_data['location'][1]
      event.longitude = event_data['location'][0]
      # Add or adjust any additional fields as per your schema
    end
    # puts "Event #{event_data['title']} created."
  end
else
  puts 'JSON file with event data not found.'
end


# events_file_path = Rails.root.join('db', 'movie_theaters_data.json')
# events = JSON.parse(File.read(theaters_file_path)) if File.exist?(events_file_path)
# events ||= []

# Seeding movies from TMDB and assigning random theater addresses
# puts "Seeding Events from Predict HQ..."
# events_file_path = Rails.root.join('db', 'predict_hq_events.json')
# if File.exist?(events_file_path)
#   events = JSON.parse(File.read(events_file_path))
#   events.each do |event_data|
#     if events.any?
#       Event.find_or_create_by!(id: event_data['id']) do |event|
#         event.name = event_data['title']
#         event.address = event_data.dig('entities', 0, 'formatted_address') || 'Address not provided'
#         event.date = Date.parse(event_data['start']) rescue nil # Handle date parsing gracefully
#         event.description = event_data['description']
#         # event.website = 'https://predicthq.com' # Placeholder, adjust as needed
#         # event.img = 'default_image_path' # Placeholder, adjust as needed
#         # Assuming location is structured as [longitude, latitude]
#         event.latitude = event_data['location'][1]
#         event.longitude = event_data['location'][0]
#         # Add or adjust any additional fields as per your schema
#       end
#     else
#       puts "No event data available"
#     end
#   end
#   puts 'Movies seeded successfully.'
# end


def import_businesses_from_json(term)
  file_path = Rails.root.join('db', "#{term.gsub(' ', '_')}_data.json")
  if File.exist?(file_path)
    data = JSON.parse(File.read(file_path))
    data.each do |item|
      case term
      when 'restaurants'
        Restaurant.find_or_create_by(name: item['name']) do |r|
          r.address = item['location']['address1']
          r.rating = item['rating'].to_f
          r.cuisine = item['categories'].map { |cat| cat['title'] }.join(', ')
          r.price_level = item['price']
          r.website = item['url']
          r.hours = item['hours'].to_json
          r.photo = item['image_url']
          r.latitude = item['coordinates']['latitude']
          r.longitude = item['coordinates']['longitude']
        end
      when 'attractions'
        Attraction.find_or_create_by(name: item['name']) do |a|
          a.address = item['location']['address1']
          a.img = item['image_url']
          a.website = item['url']
          a.latitude = item['coordinates']['latitude']
          a.longitude = item['coordinates']['longitude']
          a.hours = item['hours'].to_json
        end
      end
    end
    puts "#{term.capitalize} imported successfully."
  else
    puts "No JSON file found for #{term}."
  end
end

# Seed businesses
['restaurants', 'attractions'].each do |term|
  import_businesses_from_json(term)
end

# Load movie theaters data for address assignment to movies
theaters_file_path = Rails.root.join('db', 'movie_theaters_data.json')
theaters = JSON.parse(File.read(theaters_file_path)) if File.exist?(theaters_file_path)
theaters ||= []

# Seeding movies from TMDB and assigning random theater addresses
puts "Seeding Movies from TMDB..."
movies_file_path = Rails.root.join('db', 'movies_now_playing.json')
if File.exist?(movies_file_path)
  movies = JSON.parse(File.read(movies_file_path))
  movies.each do |movie|
    if theaters.any?
      random_theater = theaters.sample # Pick a random theater
      Movie.find_or_create_by(title: movie['title']) do |m|
        m.description = movie['overview']
        m.poster = "https://image.tmdb.org/t/p/original#{movie['poster_path']}"
        m.rating = movie['vote_average'].to_s
        m.genre = movie['genre_names']
        m.address = random_theater['location']['address1']
        m.latitude = random_theater['coordinates']['latitude']
        m.longitude = random_theater['coordinates']['longitude']
        # Assign a random screen time, if necessary
        m.screen_time = Date.today + rand(-15..15).days
      end
    else
      puts "No movie theater data available for address assignment."
    end
  end
  puts 'Movies seeded successfully.'
end

puts "Database seeding completed!"
