# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Initial users datas
puts "Destroy datas"
Recommendation.destroy_all
User.destroy_all
Attraction.destroy_all
Event.destroy_all
Restaurant.destroy_all
Movie.destroy_all

puts "Seed Users..."
User.create!(email: 'yuefei@hackers.com', password: 'password', first_name: 'Yuefei', last_name: 'Dong')
User.create!(email: 'declan@hackers.com', password: 'password', first_name: 'Declan', last_name: 'Schindler')
User.create!(email: 'laurent@hackers.com', password: 'password', first_name: 'Laurent', last_name: 'Lefebvre')
puts "Users seed successed!"

puts "Seed Restaurants..."
Restaurant.create!(name: 'Buger de Ville', address: '5282 St Laurent Blvd, Montreal, Quebec H2T 1S5', rating: 4.3, cuisine: 'Burger', price_level: '$' * rand(3), website: 'Soon...', hours: '7-11', photo: 'restaurants_burger.jpg')
Restaurant.create!(name: 'In Gamba', address: '71 St Viateur St. E, Montreal, Quebec H2T 1A7', rating: 4.6, cuisine: 'Cafe', price_level: '$$$', website: 'Soon...', hours: '7-11', photo: 'restaurants_coffe.jpg')
Restaurant.create!(name: 'Chez Claudette', address: '351 Laurier Ave E, Montreal, Quebec H2T 1G7', rating: 4.4, cuisine: 'poutine', price_level: '$$', website: 'Soon...', hours: '7-11', photo: 'restaurants_fries.jpg')
puts "Restaurants seed successed!"

puts "Seed Attractions..."
Attraction.create!(name: 'Vieux-Port de Montréal', address: '333 Rue de la Commune O, Montréal, QC H2Y 2E2', img: 'vieux_port.jpeg', website: 'http://www.vieuxportdemontreal.com/')
Attraction.create!(name: 'Grand Staircase of Mount Royal', address: 'Le Serpentin, Montreal, Quebec H3H 1A2', img: 'grand_stairs.jpeg', website: 'Soon...')
Attraction.create!(name: 'Notre-Dame Basilica of Montreal', address: '110 Notre-Dame St W, Montreal, Quebec H2Y 1T1', img: 'notre_dame.jpeg', website: 'https://www.basiliquenotredame.ca/')
puts "Attractions seed successed!"

puts "Seed events..."
Event.create!(name: 'Taylor Swift Dance Party', address: 'Muzique Nightclub, 3781 Boulevard Saint-Laurent Montréal, QC H2W 1X8', date: '2024-03-16'.to_date, description: "Montreal Swifties Unite!! SWIFTIES SOCIALS is back with the Biggest Taylor Swift Dance Party in MTL! Come party with 500+ Swifties who share your love for Taylor's music. Sing along, dance like nobody's watching, and create memories that will last a lifetime.", website: 'https://www.eventbrite.ca/e/taylor-swift-dance-party-swifties-socials-montreal-march-16-tickets-826346463517?aff=ebdssbdestsearch', img: 'taylor.jpeg')
Event.create!(name: 'MONTREAL CAREER FAIR', address: 'Montreal Convention Centre, 1001 Place Jean-Paul-Riopelle Montréal, QC H2Z 1H5', date: '2024-03-20'.to_date, description: "Welcome to Jobs Canada Centre.Come and meet with recruiters in person, make a positive impression, and demonstrate your skills and qualifications. It doesn't matter what industry or background you have; whether you've recently graduated, are a skilled professional, or are looking for a fresh start, join Jobs Canada across the country. Expand your professional network, gain insights into the current job market, and bring your resume to interact with employers, industry professionals, and other attendees. Follow us for latest updates. We are here to help you!", website: 'https://www.eventbrite.ca/e/montreal-career-fair-march-20th2024-tickets-706882463477?aff=ebdssbcitybrowse', img: 'job.jpeg')
Event.create!(name: 'Montreal Networking Event For Professionals', address: 'Lounge h3, 340 Rue De la Gauchetière Ouest #2e étage Montréal, QC H2Z 0C3', date: '2024-03-15'.to_date, description: "SUM OF FIVE Professional Networking Events stand as the pinnacle of stylish gatherings for both young professionals. Our main goal revolves around empowering our attendees by facilitating meaningful professional connections. We have an unwavering commitment that lies in fostering genuine relationships among peers, cultivating an environment where professionals can seamlessly connect and engage in a purposeful manner. We aspire to aid participants in their journey of expanding their businesses and advancing their careers by providing a platform to engage with individuals who share similar aspirations.", website: 'https://www.eventbrite.ca/e/montreal-networking-event-for-professionals-lounge-h3-tickets-843030616267?aff=ebdssbdestsearch', img: 'job2.jpeg')
puts "Events seed successed!"

puts "Seed Movie"
Movie.create!(title: 'Godzilla x Kong: The New Empire', theater_address: '1234 Montreal', screen_time: '2024-03-29'.to_date, poster: 'gk.jpg', description: 'Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.', rating: 'PG-13', genre: 'Action, Science Fiction, Adventure')
Movie.create!(title: 'Dogman', theater_address: '4563 Montreal', screen_time: '2024-03-22'.to_date, poster: 'dogman.jpeg', description: 'A boy, bruised by life, finds his salvation through the love of his dogs.', rating: 'R', genre: 'Action, Drama, Crime')
Movie.create!(title: 'Ghostbusters: Frozen Empire', theater_address: '678 Montreal', screen_time: '2024-03-22'.to_date, poster: 'ghost_fe.jpeg', description: "The Spengler family returns to where it all started – the iconic New York City firehouse – to team up with the original Ghostbusters, who've developed a top-secret research lab to take busting ghosts to the next level. But when the discovery of an ancient artifact unleashes an evil force, Ghostbusters new and old must join forces to protect their home and save the world from a second Ice Age.", rating: 'PG-13', genre: 'Fantasy, Adventure, Comedy')
puts "Movie seed successed!"

puts "Database seed accomplished!"
