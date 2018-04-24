class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:create]


  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      # render :show, status: :created, location: @friend_request
      redirect_back(fallback_location: root_path)
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def update
    @friend_request.accept
    flash[:notice] = "接受成為好友"
    redirect_back(fallback_location: root_path)
    # head :no_content
  end

  def destroy
    @friend_request.destroy
    flash[:notice] = "拒絕成為好友"
    redirect_back(fallback_location: root_path)
    # head :no_content
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find_by(friend_id: params[:id])
  end
end
