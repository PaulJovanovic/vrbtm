class Source < ActiveRecord::Base
  extend FriendlyId

  has_many :quotes, as: :citable
  has_many :posts, through: :quotes

  validates :name, presence: true

  friendly_id :name, use: :slugged

  def self.search_by_name(name)
    where('lower(name) LIKE ?', "#{name.downcase}%")
  end

  def self.exact_search_by_name(name)
    where('lower(name) LIKE ?', "#{name.downcase}")
  end

  def search_image
    "/assets/source_icon.png"
  end

  def search_info
    count = quotes.count
    "#{count} #{"quote".pluralize(count)}"
  end
end
