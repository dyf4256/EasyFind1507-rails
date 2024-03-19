class AddCoordinatesToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :latitude, :float
    add_column :movies, :longitude, :float
  end
end
