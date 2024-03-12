class AddPhotoToRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :photo, :string
  end
end
