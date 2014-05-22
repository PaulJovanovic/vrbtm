class AddSlugToSources < ActiveRecord::Migration
  def change
    add_column :sources, :slug, :string
  end
end
