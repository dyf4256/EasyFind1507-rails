class Event < ApplicationRecord
  has_many :recommendations, as: :activity
end
