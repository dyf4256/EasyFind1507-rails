class Attraction < ApplicationRecord
  include Activities

  alias_attribute :photo, :img
end
