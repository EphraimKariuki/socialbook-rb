class FollowsController < ApplicationController
  def index
    @follows = Follow.all
  end

  def new
    @user = User.find(params[:user_id])
    @follow = @user.followed_follows.build(follower_id: current_user.id)
  end

  def create
    @user = User.find(params[:user_id])
    @follow = @user.followed_follows.build(follower: current_user)

    if @follow.save
      redirect_to users_path, notice: "You followed this user."
    else
      redirect_to users_path, alert: "Unable to follow this user."
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @follow = @user.followed_follows.find(params[:id])
    if @follow.follower == current_user
      @follow.destroy
      redirect_to users_path, notice: "You unfollowed this user."
    else
      redirect_to users_path, alert: "Unable to unfollow this user."
    end
  end
end
