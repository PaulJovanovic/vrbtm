class CreateQuotesTags < ActiveRecord::Migration
  def change
    create_table :quotes_tags do |t|
      t.integer :quote_id
      t.integer :tag_id
    end
  end
end
