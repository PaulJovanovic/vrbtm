class Source < ActiveRecord::Base
  has_many :quotes, as: :citable

  def self.search_by_name(name)
    where('name LIKE ?', "#{name}%")
  end
end