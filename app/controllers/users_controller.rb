class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @likes = @user.likes
    @followers = @user.followed_follows
    @followings = @user.follower_follows
  end
end
