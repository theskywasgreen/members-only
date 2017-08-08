class PostsController < ApplicationController
  before_action :require_signin, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Post successfully submitted!"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all.order('created_at DESC')
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def require_signin
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to signin_path
    end
  end
end
