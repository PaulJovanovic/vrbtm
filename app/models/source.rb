class Source < ActiveRecord::Base
  has_many :quotes, as: :citable
end