namespace :eventbrite do
  desc "Fetch events from Eventbrite and populate the Event model"
  task fetch_and_save_events: :environment do
    events = EventbriteService.new.fetch_and_filter_events

    events.each do |event_data|
      Event.find_or_create_by(name: event_data[:name]) do |event|
        event.address = event_data[:address]
        event.date = event_data[:date]
        event.description = event_data[:description]
        event.website = event_data[:website]
        event.img = event_data[:img]
        event.latitude = event_data[:latitude]
        event.longitude = event_data[:longitude]
      end
    end

    puts "Fetched and saved #{events.size} events."
  end
end

#You can run this rake task with the command: bundle exec rake eventbrite:fetch_and_save_events
