class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User", counter_cache: :following_count
  belongs_to :followed, class_name: "User", counter_cache: :followers_count
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :notify_user, if: :notify_user?

  private

  def notify_user?
    Notification.where(notifiable_type: "User", notifiable_id: follower.id, from_user: follower, to_user: followed, action: "started following").count == 0
  end

  def notify_user
    Notification.create(notifiable_type: "User", notifiable_id: follower.id, from_user: follower, to_user: followed, subject: follower.name, action: "started following", text: "you")
  end

end
