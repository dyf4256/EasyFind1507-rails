class Attraction < ApplicationRecord
  include Activities
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
