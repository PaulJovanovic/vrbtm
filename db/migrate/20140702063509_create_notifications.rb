class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notifiable_type
      t.integer :notifiable_id
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :subject
      t.string :action
      t.string :text
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
