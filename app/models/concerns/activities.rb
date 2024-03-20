require "active_support/concern"

module Activities
  extend ActiveSupport::Concern

  SUPPORTED = ['Restaurant', 'Event', 'Attraction', 'Movie']

  def self.supported?(type)
    SUPPORTED.include?(type.capitalize)
  end

  included do
    acts_as_favoritable
    has_many :recommendations, as: :activity
    geocoded_by :address
    after_validation :geocode, if: :will_save_change_to_address?
  end

  # class_methods do
  #   ...
  # end
end
