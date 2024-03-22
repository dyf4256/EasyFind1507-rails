class AddDistanceFilterToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :distance_filter, :string, null: false, default: 'none'
  end
end
