class AdjustHoursInRestaurantsAndAddToAttractions < ActiveRecord::Migration[7.1]
  def change
    # Only add this line if the current column type for hours is not text
    change_column :restaurants, :hours, :text

    # Add hours column to attractions
    add_column :attractions, :hours, :text
  end
end
