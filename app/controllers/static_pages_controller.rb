class StaticPagesController < ApplicationController
  def home
    if logged_in?
      #current_user.microposts.buildは、Micropost.new(user_id: current_user.id)と同じです。
      #前者の方はcurrent_userのhas_many :micropostsで生成されるbuildメソッドを使用していて、
      #確実にuser_idが紐付いたデータを作成できるのでこちらを使用するようにしましょう。
      @micropost = current_user.microposts.build
      
      #feed_itemsで現在のユーザーのフォローしているユーザーを取得し、
      #order(created_at: :desc)投稿日で並び替えを行っています
      #includes(:user)の部分は、つぶやきに含まれるユーザー情報をあらかじめ先読み
      #（プリロード）する処理を行うために用います
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
