class PostsController < ApplicationController
  before_action :authenticate_user!


  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @like = Like.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to @post, alert: "You are not authorized to edit this post."
    end
  end

  def update
    post = Post.find(params[:id])
    if post.user == current_user
      if post.update(post_params)
        redirect_to post, notice: "Post was successfully updated."
      else
        render :edit
      end
    else
      redirect_to post, alert: "You are not authorized to update this post."
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "Post was successfully deleted."
    else
      redirect_to post, alert: "You are not authorized to delete this post."
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
