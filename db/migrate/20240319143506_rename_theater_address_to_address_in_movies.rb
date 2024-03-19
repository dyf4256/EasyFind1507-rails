class RenameTheaterAddressToAddressInMovies < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :theater_address, :address
  end
end
