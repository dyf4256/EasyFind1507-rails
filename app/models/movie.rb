class Movie < ApplicationRecord
  include Activities

  alias_attribute :name, :title
  alias_attribute :photo, :poster
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
end
