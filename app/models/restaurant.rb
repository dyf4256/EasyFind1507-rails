class Restaurant < ApplicationRecord
  has_many :recommendations, as: :activity
  has_many :restaurant_reviews
end
