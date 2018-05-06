require 'rails_helper'

RSpec.describe 'User', type: :request do

  let(:user) { create(:user) }
  let(:user2) { create(:user, name: "user2")}
  let(:post) { create(:post, user: user) }

  context '#show' do
    # user must sign_in
    # show user profile
    # show others profile
    # show user's posts
    # show others posts
    # show user's draft posts
    # can's see others draft posts
    # show user's collects
    # can't see others collects
    # show user's friends
    # can't others friends
    # show user's friend requests
    describe 'go to user profile page' do
      it 'user not sign in' do
        get user_path(user)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'user sign in can see profile' do
        sign_in(user)
        get user_path(user)
        expect(user.posts.count).to eq 0
      end

    end

  end

  context '#edit' do
    # user must sign_in
    # user can edit post by yourself after sign_in
    # user can't edit others posts

  end

  context '#update' do
    # user can update edit

  end
end