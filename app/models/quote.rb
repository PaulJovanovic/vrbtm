class Quote < ActiveRecord::Base
  has_many :posts
  belongs_to :citable, polymorphic: true

  def name
    if citable_type == "User"
      "(#{citable.name})"
    else
      citable.name
    end
  end
end