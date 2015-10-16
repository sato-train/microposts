class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase}

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255},
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false}

  validates :description, length: { maximum: 200 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :url, length: { maximum: 255 }, presence: true
  VALID_DATE_REGEX = /(\d{4})?-(\d{2})-?(\d{2})/
  validates :birthday, format: { with: VALID_DATE_REGEX }, presence: true

  has_secure_password

  #それぞれのユーザーは複数の投稿を持つことができる。
  has_many :microposts
end
