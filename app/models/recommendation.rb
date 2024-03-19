class Recommendation < ApplicationRecord
  belongs_to :activity, polymorphic: true
  belongs_to :session
  enum :status, {
    pending: 0,
    rejected: 1,
    accepted: 2,
    bookmarked: 3
  }
end
