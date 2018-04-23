class AddContentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :content, :text, limit: 300
  end
end
