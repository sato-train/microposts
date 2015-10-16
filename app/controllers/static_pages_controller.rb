class StaticPagesController < ApplicationController
  def home
    #current_user.microposts.buildは、Micropost.new(user_id: current_user.id)と同じです。
    #前者の方はcurrent_userのhas_many :micropostsで生成されるbuildメソッドを使用していて、
    #確実にuser_idが紐付いたデータを作成できるのでこちらを使用するようにしましょう。
    @micropost = current_user.microposts.build if logged_in?
  end
end
