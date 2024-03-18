class UpdateRecommendations < ActiveRecord::Migration[7.1]
  def change
    remove_reference :recommendations, :user, foreign_key: true
    add_reference :recommendations, :session, foreign_key: true
  end
end
