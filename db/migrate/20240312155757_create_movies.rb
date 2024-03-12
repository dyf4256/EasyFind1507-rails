class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :theater_address
      t.date :screen_time
      t.string :poster
      t.string :rating
      t.string :genre

      t.timestamps
    end
  end
end
