class UsersController < ApplicationController

  before_action :set_user, only: [:show,:following,:followers,:edit,:update]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @microposts = @user.microposts.page(params[:page])
    @favorite_microposts = @user.user_favorits
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      #あらかじめconfig/routes.rbでresources :usersを設定しておくと
      #reidect_to user_path(@user) と同じ動作をする
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @users = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @users = @user.follower_users
    render 'show_follow'
  end
  
  private
  
  def user_params
    params.require(:user).permit(
          :name,:email,:password,:password_confirmation,
          :description,:place,:url,:birthday
        )
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
