class Movie < ApplicationRecord
  has_many :recommendations, as: :activity
end
