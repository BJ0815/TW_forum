class AddCountToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :replies_count, :integer, default: 0
    add_column :posts, :views_count, :integer, default: 0

    Post.pluck(:id).each do |i|
      Post.reset_counters(i, :replies)
    end
  end
end
