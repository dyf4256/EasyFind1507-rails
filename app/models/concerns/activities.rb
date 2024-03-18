require "active_support/concern"

module Activities
  extend ActiveSupport::Concern

  included do
    acts_as_favoritable
    has_many :recommendations, as: :activity
  end

  # class_methods do
  #   ...
  # end
end
