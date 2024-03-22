class Event < ApplicationRecord
  include Activities
  alias_attribute :photo, :img
end
