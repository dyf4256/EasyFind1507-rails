class Restaurant < ApplicationRecord
  include Activities
  has_many :restaurant_reviews
end
