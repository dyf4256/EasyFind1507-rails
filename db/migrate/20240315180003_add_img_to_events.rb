class AddImgToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :img, :string
  end
end
