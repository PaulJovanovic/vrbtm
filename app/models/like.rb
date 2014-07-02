class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user

  after_create :notify_user, if: :notify_user?
  after_create :increment_like_count
  after_destroy :decrement_like_count

  private

  def notify_user?
    user_id != likable.user_id && Notification.where(notifiable_type: likable_type, notifiable_id: likable_id, from_user: user, to_user: likable.user, action: "starred").count == 0
  end

  def notify_user
    Notification.create(notifiable_type: likable_type, notifiable_id: likable_id, from_user: user, to_user: likable.user, subject: user.name, action: "starred", text: "your #{likable.notification_text}")
  end

  def increment_like_count
    likable_type.constantize.increment_counter(:likes_count, likable_id)
  end

  def decrement_like_count
    likable_type.constantize.decrement_counter(:likes_count, likable_id)
  end
end
