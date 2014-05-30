class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :assetable_type
      t.integer :assetable_id
      t.attachment :attachment
    end
  end
end
