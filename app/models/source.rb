class Source < ActiveRecord::Base
  has_many :quotes, as: :citable

  def self.search_by_name(name)
    where('lower(name) LIKE ?', "#{name.downcase}%")
  end
end