class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :quotes, as: :citable
  has_many :posts
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship"
  has_many :follows, through: :relationships
  has_many :followers, through: :reverse_relationships

  def self.search_by_name(name)
    names = name.split(" ")
    if names.length == 1
      search = "#{names[0]}%"
      find(:all, :conditions => ['first_name LIKE ? OR last_name LIKE ?', search, search])
    else
      find(:all, :conditions => ['first_name LIKE ? AND last_name LIKE ?', "#{names[0]}%", "#{names[1..names.length].join(" ")}%"])
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def feed
    Post.from_users_followed_by(self)
  end

  def following?(user)
    relationships.find_by(followed_id: user.id)
  end

  def follow!(user)
    relationships.create!(followed_id: user.id)
  end

  def unfollow!(user)
    relationships.find_by(followed_id: user.id).destroy
  end

end