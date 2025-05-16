class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def new
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user_id: current_user.id)
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    # @like.user = current_user


    if @like.save
      redirect_to posts_path, notice: "You liked this post."
    else
      redirect_to posts_path, alert: "Unable to like this post."
    end
  end
  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])
    if @like.user == current_user
      @like.destroy
      redirect_to posts_path, notice: "You unliked this post."
    else
      redirect_to posts_path, alert: "Unable to unlike this post."
    end
  end
end
