class AddCoordinatesToAttractions < ActiveRecord::Migration[7.1]
  def change
    add_column :attractions, :latitude, :float
    add_column :attractions, :longitude, :float
  end
end
