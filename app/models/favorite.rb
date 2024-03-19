# frozen_string_literal: true

class Favorite < ApplicationRecord
  extend ActsAsFavoritor::FavoriteScopes

  belongs_to :favoritable, polymorphic: true
  belongs_to :favoritor, polymorphic: true

  alias_attribute :activity_type, :favoritable_type
  alias_attribute :activity_id, :favoritable_id
  alias_attribute :activity, :favoritable

  def block!
    update!(blocked: true)
  end
end
