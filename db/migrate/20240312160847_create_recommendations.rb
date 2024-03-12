class CreateRecommendations < ActiveRecord::Migration[7.1]
  def change
    create_table :recommendations do |t|
      t.references :user, foreign_key: true
      t.integer :status, null: false, default: 0
      t.references :activity, polymorphic: true

      t.timestamps
    end
  end
end
