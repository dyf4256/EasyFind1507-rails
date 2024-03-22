class Session < ApplicationRecord
  # INFO: The distance filters values are in kilometers because that's how the
  # gem Geocoder is currently configured. If this ever changes, please update
  # the following values accordingly.
  # enum :distance, {
  #   disabled: 0,
  #   walk: 1,
  #   bike: 2,
  #   car: 3
  # }, suffix: true

  DISTANCE_FILTERS = {
    'walk' => 2,
    'bike' => 5,
    'car' => 15,
    'none' => 1000
  }

  belongs_to :user
  has_many :recommendations
  has_one :accepted_recommendation, -> { where status: 2 }, class_name: 'Recommendation', foreign_key: :session_id
  has_one :pending_recommendation, -> { where status: 0 }, class_name: 'Recommendation', foreign_key: :session_id
  has_many :bookmarked_recommendations, -> { where status: 3 }, class_name: 'Recommendation', foreign_key: :session_id
  has_many :rejected_recommendations, -> { where status: 1 }, class_name: 'Recommendation', foreign_key: :session_id

  validates :distance_filter, presence: true, inclusion: { in: DISTANCE_FILTERS.keys + ['none'] }

  scope :active, -> { where active: true }
  scope :completed, -> { where active: false }
  scope :by_type, ->(type) { where activity_type: type }

  def end!
    update(active: false)
  end

  def completed?
    !active
  end

  def pending_recommendation?
    !pending_recommendation.nil?
  end
end
