class Movie < ApplicationRecord
  include Activities

  alias_attribute :name, :title
  alias_attribute :photo, :poster
end
