class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :citable_type
      t.integer :citable_id
      t.string :text
      t.timestamps
    end
  end
end
