class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :destroy]

  def index
    @posts = Post.article_role(current_user)
    render json: {
      data: @posts.map do |post|
        {
          title: post.title,
          description: post.description,
          photo: post.photo,
          replies_count: post.replies_count,
          views_count: post.views_count
        }
      end
    }
  end

  def show
    if @post
      if @post.can_watch(current_user)
        render json: {
          data: {
            title: @post.title,
            description: @post.description,
            photo: @post.photo,
            replies_count: @post.replies_count,
            views_count: @post.views_count
          }
        }
      else
        render json: {
          message: "Not Allow",
          status: 400
        }
      end
    else
      render json: {
        message: "Can't find the post",
        status: 400
      }
    end
  end 

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.user == current_user
      if @post.update(post_params)
        render json: {
          message: "Post updated successfully!",
          result: @post
        }
      else
        render json: {
          message: @post.errors
        }
      end
    end
  end

  def destroy
    @post.destroy
    render json: {
      message: "Post destroy successfully!"
    }
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.permit(:user_id, :title, :description, :file_location, :state, :article_role, category_ids:[])
  end
end
