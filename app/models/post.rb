class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :origin_user, class_name: "User"
  belongs_to :quote, counter_cache: true
  has_many :likes, as: :likable, dependent: :destroy
  accepts_nested_attributes_for :quote

  validates :user, :quote, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  def user_name
    if origin_user
      origin_user.name
    else
      user.name
    end
  end

  def posted_by_user
    origin_user || user
  end

  def liked_by?(user)
    likes.where(user: user).count == 1
  end
end
