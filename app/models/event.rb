class Event < ApplicationRecord
  include Activities

  alias_attribute :photo, :img
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
end
