class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true
  belongs_to :user

  validates :post, :user, :text, presence: true
  after_create :notify_user, if: :notify_user?

  private

  def notify_user?
    user_id != post.user_id && Notification.where(notifiable_type: "Post", notifiable_id: post_id, from_user: user, to_user: post.user, action: "commented on").count == 0
  end

  def notify_user
    Notification.create(notifiable_type: "Post", notifiable_id: post_id, from_user: user, to_user: post.user, subject: user.name, action: "commented on", text: "your post: \"#{text.truncate(30)}\"")
  end

end
