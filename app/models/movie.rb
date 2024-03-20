class Movie < ApplicationRecord
  include Activities

  alias_attribute :name, :title
end
