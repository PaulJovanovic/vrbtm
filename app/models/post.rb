class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :quote
  accepts_nested_attributes_for :quote
end