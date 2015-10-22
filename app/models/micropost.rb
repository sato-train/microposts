class Micropost < ActiveRecord::Base
  #それぞれの投稿は特定の1人のユーザーのものである。
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140}

  #kaminari Plugin Setting
  default_scope { order('created_at DESC') }
  paginates_per 5  # 1ページあたり5項目表示

  mount_uploader :image, ImageUploader
end
