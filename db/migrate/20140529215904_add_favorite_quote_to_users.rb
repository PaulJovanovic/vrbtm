class AddFavoriteQuoteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_quote, :string
    add_column :users, :favorite_quote_author, :string
  end
end
