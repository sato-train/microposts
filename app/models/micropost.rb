class Micropost < ActiveRecord::Base
  #それぞれの投稿は特定の1人のユーザーのものである。
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140}

  default_scope { order('created_at DESC') }
end
