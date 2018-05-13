require 'rails_helper'

RSpec.describe 'User', type: :request do

  let(:user) { create(:user) }
  let(:user2) { create(:user, name: "user2")}

  context '#show' do
    # user must sign_in can see show
    # show user profile
    # show others profile
    describe 'go to user profile page' do
      it 'user not sign in' do
        get user_path(user)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'user sign in can see profile' do
        sign_in(user)
        get user_path(user)
        expect(response).to render_template(:show)
      end

      it 'user sign in can see others profile' do
        sign_in(user)
        get user_path(user2)
        expect(user2.posts.count).to eq 0
      end

    end

  end

  context '#edit' do
    # user must sign_in
    # user can edit post by yourself after sign_in
    # user can't edit others user profile
    describe 'go to user edit page' do
      it 'user not sign in' do
        get edit_user_path(user)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'user can edit user profile by yourself after sign_in' do
        sign_in(user)
        get edit_user_path(user)
        expect(response).to render_template(:edit)
      end

      it 'user can edit others profile by yourself after sign_in' do
        sign_in(user)
        get edit_user_path(user2)
        expect(response).to redirect_to(root_path)
      end

    end

  end

  context '#update' do
    # user can update edit
    it 'successfully update profile' do
      sign_in(user)
      patch "/users/#{user.id}" , params: {
        user: {
          name: 'manager'
        }
      }

      user.reload
      expect(user.name).to eq('manager')
    end
  end

end