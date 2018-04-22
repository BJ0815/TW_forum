class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @article_roles = [:All, :Friend, :Myself]
    @category = Category.all
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "successfully created"
      redirect_to root_path
    else
      flash[:alert] = @post.errors.full_messages
      render :new
    end
  end

  private 

  def post_params
    params.require(:post).permit(:title, :photo, :state, :article_role, :category_id, :description)
  end
end
