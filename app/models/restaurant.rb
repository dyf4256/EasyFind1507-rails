class Restaurant < ApplicationRecord
  has_many :recommendations, as: :activity
end
