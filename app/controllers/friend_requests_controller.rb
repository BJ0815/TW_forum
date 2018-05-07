class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, except: [:create]


  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      # render :show, status: :created, location: @friend_request
      redirect_back(fallback_location: root_path)
    else
      # render json: @friend_request.errors, status: :unprocessable_entity
      flash[:alert] = @friend_request.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @friend_request.accept
    flash[:notice] = "接受成為好友"
    respond_to do |format|
      format.html { redirect_back(fallback_location: request.referer ) }
      format.js
    end
  end

  def destroy
    @friend_request.destroy
    flash[:notice] = "拒絕成為好友"
    respond_to do |format|
      format.html { redirect_back(fallback_location: request.referer ) }
      format.js
    end
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find_by(friend_id: params[:id])
  end
end
