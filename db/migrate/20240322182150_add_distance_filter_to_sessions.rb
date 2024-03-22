class AddDistanceFilterToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :distance_filter, :integer, null: false, default: 0
  end
end
