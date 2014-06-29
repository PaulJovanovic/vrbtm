class AddFollowingCountToUsers < ActiveRecord::Migration
  def change
    # add_column :users, :following_count, :integer, default: 0

    User.find_each do |u|
      User.reset_counters u.id, :following
    end
  end
end
