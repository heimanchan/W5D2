class PostsController < ApplicationController
  before_action :require_login, except: :show

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @all_comments = @post.comments.includes(:child_comments).where(parent_comment_id: nil)
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids:[])
  end
end
