class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_post, except: [:index, :new, :create, :feed]
  after_action :view_count, only: :show

  def index
    @categories = Category.all

    if params[:category]
      @posts = Category.find(params[:category]).posts.includes(:replies).article_role(current_user).publics.page(params[:page]).per(20)
    else
      @posts = Post.includes(:replies).article_role(current_user).page(params[:page]).per(20)
    end

  end

  def feed
    @posts = Post.all
    @users = User.all
    @replies = Reply.all
    @rank_users = User.all.order('replies_count DESC').limit(10)
    @rank_posts = Post.all.order('replies_count DESC').limit(10)
  end
      

  def new
    @post = Post.new
  end

  def create
    # 新增文章（存為草稿Draft或是直接發佈public)
    # 設定文章權限article_role(:all, :friend, :myself)
    @post = current_user.posts.new(post_params)
    if params[:commit] == "Save Draft"
      @post.state = "draft"
      if @post.save
        flash[:notice] = "成功儲存草稿"
        redirect_to post_path(@post)
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :new
      end
    else
      @post.state = "public"
      if @post.save
        flash[:notice] = "成功發佈"
        redirect_to post_path(@post)
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :new
      end
    end
  end

  def show
    @reply = Reply.new
    @replies = @post.replies.all.page(params[:page]).per(20)
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
    if current_user == @post.user || current_user.admin?
      @post.destroy
      flash[:notice] = "成功刪除post"
      redirect_back(fallback_location: root_path)
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
    params.require(:post).permit(:title, :photo, :state, :article_role, :description, category_ids:[])
  end

  def view_count
    @post.views_count += 1
    @post.save!
  end


end
