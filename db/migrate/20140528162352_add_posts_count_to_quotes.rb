class AddPostsCountToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :posts_count, :integer, :default => 0

    Quote.all.each do |quote|
      Quote.update_counters quote.id, :posts_count => quote.posts.length
    end
  end
end
