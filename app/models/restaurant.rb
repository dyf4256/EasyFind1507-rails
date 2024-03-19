class Restaurant < ApplicationRecord
  include Activities
  has_many :restaurant_reviews
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
