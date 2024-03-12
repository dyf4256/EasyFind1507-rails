class CreateAttractions < ActiveRecord::Migration[7.1]
  def change
    create_table :attractions do |t|
      t.string :name
      t.string :address
      t.string :img
      t.string :website

      t.timestamps
    end
  end
end
