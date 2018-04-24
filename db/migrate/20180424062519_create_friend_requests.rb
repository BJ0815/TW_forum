class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.references :user
      t.references :friend

      t.timestamps
    end
  end
end
