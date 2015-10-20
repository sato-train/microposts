class FavoritesController < ApplicationController

  before_action :logged_in_user

  def create
    #登録するつぶやきのIDをパラメータとして
    #Userモデルのfavoriteメソッドを実行
    current_user.favorite(params[:micropost_id])
    redirect_to request.referrer || root_url
  end

  def destroy
    #つぶやきのIDを引数としてUserのunfollowメソッドを実行
    current_user.unfavorite(params[:id])
    redirect_to request.referrer || root_url
  end
end
