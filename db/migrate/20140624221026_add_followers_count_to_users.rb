class AddFollowersCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :followers_count, :integer, default: 0

    User.find_each do |u|
      User.reset_counters u.id, :followers
    end
  end
end
