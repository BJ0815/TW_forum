class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_post, except: [:index, :new, :create]
  after_action :view_count, only: :show

  def index
    @posts = Post.all
    @categories = Category.all
    case params[:order]
    when "replies"
      @posts = Post.all.includes(:replies).order('replies_count DESC')
    when "last_replies"
      @posts = Post.all.includes(:replies).order("replies.created_at DESC")
    when "views"
      @posts = Post.all.order('views_count DESC')
    else
      @posts = Post.all
    end

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
        flash[:notice] = "成功發佈"
        redirect_to root_path
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :new
      end
    end
  end

  def show
    @reply = Reply.new
    @replies = @post.replies.all
  end

  def edit
    @categories = Category.all
    render :new
  end

  def update
    @categories = Category.all
    if @post.update(post_params)
      case params[:commit]
      when "Save Draft"
        @post.state = "draft"
      when "Submit"
        @post.state = "public"
      end
      @post.save!
      redirect_to post_path(@post), :notice => "Post更新完成"
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    if current_user == @post.user
      @post.destroy
      redirect_to root_path, :notice => "成功刪除post"
    end
  end

  def collect
    current_user.collects.create!(post: @post)
  end

  def uncollect
    current_user.collects.where(post: @post).destroy_all
  end

  private 

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :photo, :state, :article_role, :category_id, :description)
  end

  def view_count
    @post.views_count += 1
    @post.save!
  end


end
