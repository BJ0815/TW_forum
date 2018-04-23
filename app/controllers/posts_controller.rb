class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  after_action :view_count, only: :show

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    # 新增文章（存為草稿Draft或是直接發佈public)
    # 設定文章權限article_role(:all, :friend, :myself)
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

  def show
    @post = Post.find(params[:id])
    @reply = Reply.new
    @replies = @post.replies.all
  end



  private 

  def post_params
    params.require(:post).permit(:title, :photo, :state, :article_role, :category_id, :description)
  end

  def view_count
    @post.views_count += 1
    @post.save!
  end


end
