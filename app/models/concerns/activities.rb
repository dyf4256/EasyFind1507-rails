require "active_support/concern"

module Activities
  extend ActiveSupport::Concern

  included do
    has_many :recommendations, as: :activity
  end

  # class_methods do
  #   ...
  # end
end
