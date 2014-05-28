class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user

  after_create :increment_like_count
  after_destroy :decrement_like_count

  private

  def increment_like_count
    likable_type.constantize.increment_counter(:likes_count, likable_id)
  end

  def decrement_like_count
    likable_type.constantize.decrement_counter(:likes_count, likable_id)
  end
end