class AddPostsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :posts_count, :integer

    User.find_each do |u|
      User.reset_counters u.id, :posts
    end
  end
end
