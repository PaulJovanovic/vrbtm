class Post < ActiveRecord::Base
  has_one :photo, :as => :assetable, :class_name => "Photo", :dependent => :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments
  belongs_to :user, counter_cache: true
  belongs_to :original_post, class_name: "Post", touch: true
  belongs_to :quote, counter_cache: true
  has_and_belongs_to_many :tags

  validates :user, :quote, presence: true

  after_create :transfer_tags_to_quote

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  def original
    original_post || self
  end

  def posted_by_user
    if original_post
      original_post.user
    else
      user
    end
  end

  def user_name
    posted_by_user.name
  end

  def liked_by?(user)
    likes.where(user: user).count == 1
  end

  def transfer_tags_to_quote
    quote.tags << tags
    quote.save
  end
end
