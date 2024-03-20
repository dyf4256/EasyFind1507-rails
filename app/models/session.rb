class Session < ApplicationRecord
  belongs_to :user
  has_many :recommendations
  has_one :accepted_recommendation, -> { where status: 2 }, class_name: 'Recommendation', foreign_key: :session_id
  has_one :pending_recommendation, -> { where status: 0 }, class_name: 'Recommendation', foreign_key: :session_id
  has_many :bookmarked_recommendations, -> { where status: 3 }, class_name: 'Recommendation', foreign_key: :session_id
  has_many :rejected_recommendations, -> { where status: 1 }, class_name: 'Recommendation', foreign_key: :session_id

  scope :active, -> { where active: true }
  scope :by_type, ->(type) { where activity_type: type }

  def end!
    update(active: false)
  end

  def inactive?
    !active
  end

  def pending_recommendation?
    !pending_recommendation.nil?
  end
end
