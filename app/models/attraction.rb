class Attraction < ApplicationRecord
  has_many :recommendations, as: :activity
end
