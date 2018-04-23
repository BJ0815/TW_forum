class RepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @reply = current_user.replies.new(reply_params)
    @reply.post = @post
    @reply.save!
    redirect_back(fallback_location:root_path)
  end

  def destroy
    current_user.replies.where(id: params[:id]).destroy_all
    flash[:notice] = "成功刪除留言"
    redirect_back(fallback_location: root_path)
  end

  def edit
    # 編輯留言（並在同一頁執行）
    @reply = current_user.replies.find_by(id: params[:id])
    @post = Post.find(params[:post_id])
    @replies = @post.replies.all
    render 'posts/show.html.erb'
  end

  def update
    # 更新留言（並倒回同一頁）
    current_user.replies.find_by(id: params[:id]).update(reply_params)
    redirect_to post_path(params[:post_id]), :notice => "成功更新留言"
  end



  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
