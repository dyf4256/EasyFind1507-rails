class Recommendation < ApplicationRecord
  belongs_to :activity, polymorphic: true
  belongs_to :user
  enum :status, {
    pending: 0,
    rejected: 1,
    accepted: 2,
    favourited: 3
  }
end
