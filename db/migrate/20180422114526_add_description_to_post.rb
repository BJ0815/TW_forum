class AddDescriptionToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :description, :text
    add_column :posts, :title, :string
  end
end
