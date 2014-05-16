class Source < ActiveRecord::Base
  has_many :quotes, as: :citable

  validates :name, presence: true

  def self.search_by_name(name)
    where('lower(name) LIKE ?', "#{name.downcase}%")
  end

  def self.exact_search_by_name(name)
    where('lower(name) LIKE ?', "#{name.downcase}")
  end
end