class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @friends = @user.friends
    # 好友邀請
    @requests = FriendRequest.where(friend: current_user)
    @pending = current_user.pending_friends
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :content, :avatar, :avatar_cache)
  end
end
