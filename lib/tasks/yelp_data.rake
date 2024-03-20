namespace :yelp_data do
  desc "Fetch and save Yelp data for restaurants and attractions to JSON files"
  task fetch_and_save: :environment do
    %w[restaurants attractions].each do |term|
      puts "Fetching and saving #{term} data..."
      YelpService.save_businesses_to_json(term: term, total: 1000)
      puts "#{term.capitalize} data saved to JSON."
    end
  end
end

#run this in terminal to parse yelp api: bundle exec rake yelp_data:fetch_and_save
