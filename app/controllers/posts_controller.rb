class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @category = Category.all
  end

  def create
    @post = current_user.posts.new(post_params)
    if params[:commit] == "Save Draft"
      @post.state = "draft"
      if @post.save
        flash[:notice] = "成功儲存草稿"
        redirect_to root_path
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :new
      end
    else
      @post.state = "public"
      if @post.save
        flash[:notice] = "成功發布"
        redirect_to root_path
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :new
      end
    end
  end



  private 

  def post_params
    params.require(:post).permit(:title, :photo, :state, :article_role, :category_id, :description)
  end

end
