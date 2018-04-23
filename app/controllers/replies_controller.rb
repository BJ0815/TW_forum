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
    current_user.replies.where(id: params[:id]).delete_all
    flash[:notice] = "成功刪除留言"
    redirect_back(fallback_location: root_path)
  end


  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
