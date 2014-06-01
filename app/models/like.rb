class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user

  after_create :increment_like_count
  after_destroy :decrement_like_count

  private

  def increment_like_count
    likable.increment(:likes_count)
    likable.save
  end

  def decrement_like_count
    likable.decrement(:likes_count)
    likable.save
  end
end
