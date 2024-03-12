class CreateRestaurantReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_reviews do |t|
      t.string :title
      t.text :review
      t.integer :rating
      t.date :published_date
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
