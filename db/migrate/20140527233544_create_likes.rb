class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :likable_type
      t.integer :likable_id
      t.integer :user_id
      t.timestamps
    end

    add_index :likes, [:likable_type, :likable_id, :user_id], unique: true
  end
end
