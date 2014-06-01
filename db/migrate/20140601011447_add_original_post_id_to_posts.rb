class AddOriginalPostIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :original_post_id, :integer
    remove_column :posts, :origin_user_id, :integer
  end
end
