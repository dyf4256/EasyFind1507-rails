class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :active, null: false, default: true
      t.string :activity_type, null: false

      t.timestamps
    end
  end
end
