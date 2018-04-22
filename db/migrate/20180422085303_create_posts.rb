class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :article_role
      t.string :state
      t.string :photo

      t.timestamps
    end
  end
end
