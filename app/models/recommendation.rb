class Recommendation < ApplicationRecord
  belongs_to :activity, polymorphic: true
  belongs_to :session
  enum :status, {
    pending: 0,
    rejected: 1,
    accepted: 2,
    bookmarked: 3
  }
  scope :only_unique, -> {
    with(recommendations_with_row_numbers: Recommendation.select('id, activity_type, activity_id, ROW_NUMBER() OVER (PARTITION BY activity_type, activity_id ORDER BY status DESC, updated_at DESC) AS rn'))
      .joins("JOIN recommendations_with_row_numbers ON recommendations_with_row_numbers.id = recommendations.id AND recommendations_with_row_numbers.rn = 1")
  }
end
