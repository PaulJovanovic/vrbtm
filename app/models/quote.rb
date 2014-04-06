class Quote < ActiveRecord::Base
  belongs_to :citable, polymorphic: true
end