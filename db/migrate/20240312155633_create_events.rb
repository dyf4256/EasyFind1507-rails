class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.date :date
      t.text :description
      t.string :website

      t.timestamps
    end
  end
end
