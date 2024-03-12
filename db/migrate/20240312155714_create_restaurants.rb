class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.float :rating
      t.string :cuisine
      t.string :price_level
      t.string :website
      t.string :hours

      t.timestamps
    end
  end
end
