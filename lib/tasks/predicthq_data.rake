# lib/tasks/predict_hq.rake

namespace :predict_hq do
  desc 'Fetch PredictHQ events and save to JSON'
  task fetch_and_save_events: :environment do
    PredictHqService.fetch_events(
      country: 'CA',
      lat: 45.5,
      long: -73.56,
      scale: 100,
      total: 1000
    )
  end
  puts ENV['PREDICT_HQ_API_KEY']
end


#You can run this rake task with the command: bundle exec rake predict_hq:fetch_and_save_events
