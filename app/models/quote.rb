class Quote < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  belongs_to :citable, polymorphic: true
  belongs_to :source, foreign_key: 'citable_id', foreign_type: 'citable_type'

  def name
    if citable_type == "User"
      "(#{citable.name})"
    else
      citable.name
    end
  end
end
