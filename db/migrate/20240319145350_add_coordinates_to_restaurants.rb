class AddCoordinatesToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
  end
end
