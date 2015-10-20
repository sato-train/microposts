class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase}
  
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255},
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false}

  validates :description, length: { maximum: 200 }, presence: true, on: :update
  validates :place, length: { maximum: 100 }, presence: true, on: :update
  validates :url, length: { maximum: 255 }, presence: true, on: :update

  VALID_DATE_REGEX = /(\d{4})?-(\d{2})-?(\d{2})/
  validates :birthday, format: { with: VALID_DATE_REGEX }, presence: true, on: :update

  has_secure_password

  #それぞれのユーザーは複数の投稿を持つことができる。
  has_many :microposts

  #あるユーザー（user）がフォローしている人  
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  #source定義 --> following_users配列の元は、followed id の集合であることを明示している
  has_many :following_users, through: :following_relationships, source: :followed
  
  #あるユーザー（user）をフォローしている人
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower

  paginates_per 5  # 1ページあたり5項目表示

  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end

  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end
