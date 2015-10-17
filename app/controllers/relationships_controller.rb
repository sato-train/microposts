class RelationshipsController < ApplicationController
  
  before_action :logged_in_user
  
  def create
    #param followed_id - フォローする他のユーザーのID
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end
  
  def destroy
    #現在のユーザーのfollowing_relationshipsを検索して
    #他のユーザーをフォローしている場合はそのユーザーを引数としてunfollow
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
