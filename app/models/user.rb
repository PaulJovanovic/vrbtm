class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :quotes, as: :citable
  has_many :posts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship"
  has_many :followeds, through: :relationships
  has_many :followers, through: :reverse_relationships
  has_many :comments

  has_one :avatar, :as => :assetable, :class_name => "Avatar", :dependent => :destroy
  has_one :cover_photo, :as => :assetable, :class_name => "CoverPhoto", :dependent => :destroy

  after_save :break_posts_cache, if: "avatar && avatar.attachment_updated_at_changed?"

  accepts_nested_attributes_for :avatar, :cover_photo

  def self.from_omniauth(auth)
    where("(provider = ? and uid = ?) or email = ?", auth.provider, auth.uid, auth.info.email).first_or_initialize.tap do |user|
      if user.password.blank?
        user.password = Devise.friendly_token[0,20]
      end
      user.provider = auth.provider
      user.uid = auth.uid
      names = auth.info.name.split
      user.first_name = names[0]
      if names.length > 1
        user.last_name = names[names.length - 1]
      else
        user.last_name = ""
      end
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      unless user.avatar
        user.avatar = Avatar.new
        user.avatar.attachment = URI.parse("https://graph.facebook.com/#{user.uid}/picture?width=256&height=256")
        user.avatar.attachment_file_name = "avatar.jpg"
        user.avatar.attachment_content_type = "image/jpeg"
        user.avatar.save
        user.avatar.attachment.reprocess!
      end
      user.break_posts_cache
    end
  end

  def self.search_by_name(name)
    names = name.strip.downcase.split(" ")
    if names.length == 1
      search = "#{names[0]}%"
      where('lower(first_name) LIKE ? OR lower(last_name) LIKE ?', search, search)
    else
      where('lower(first_name) LIKE ? AND lower(last_name) LIKE ?', "#{names[0]}%", "#{names[1..names.length].join(" ")}%")
    end
  end

  def break_posts_cache
    posts.update_all({:updated_at => Time.now})
  end

  def slug
    id
  end

  def name
    if last_name.present?
      "#{first_name} #{last_name}"
    else
      first_name
    end
  end

  def search_image
    if avatar
      avatar.url(:small)
    else
      "https://s3.amazonaws.com/vrbtm2/assets/avatar.jpg"
    end
  end

  def search_info
    count = followers.count
    "#{count} #{"follower".pluralize(count)}"
  end

  def feed
    Post.from_users_followed_by(self)
  end

  def follow!(user)
    relationships.create!(followed_id: user.id)
  end

  def unfollow!(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    relationships.where(followed_id: user.id).count == 1
  end

end
