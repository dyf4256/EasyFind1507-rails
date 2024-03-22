namespace :yelp_data do
  desc "Fetch and save Yelp data for movie theaters, restaurants, and attractions to JSON files"
  task fetch_and_save: :environment do
    ['movie theaters', 'restaurants', 'attractions'].each do |term|
      puts "Fetching and saving #{term} data..."
      YelpService.save_businesses_to_json(term: term, total: 100, location: 'Montreal')
      puts "#{term.capitalize} data saved to JSON."
    end
  end
end

#run this in terminal to parse yelp api: bundle exec rake yelp_data:fetch_and_save
