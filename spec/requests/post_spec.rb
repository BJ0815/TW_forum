require 'rails_helper'

RSpec.describe 'Post', type: :request do
  include PostsHelper

  let(:user) { create(:user) }

  context "#index" do 
    before do
      create_user_list
      create_posts_list
      user
      create(:category)
      get posts_path
    end

    describe 'posts' do
      # render index
      # show post with state public 
      it 'render index' do
        expect(response).to render_template(:index)
      end

      it 'show all posts with state public' do
        expect(assigns(:posts).count).to eq 5
      end

      it 'draft can not show on index' do
        create(:post, state: 'draft')
        expect(assigns(:posts).count).to eq 5
      end

    end
  end

  context "#feed" do
    before do
      create_user_list
      create_posts_list
      user
      get feed_posts_path
    end

    it 'user not sign in' do
      expect(response).to redirect_to(new_user_session_path)
    end

    describe 'user sign in' do
      before do
        sign_in(user)
        get feed_posts_path
      end

      it 'show all posts count' do
        expect(assigns(:posts).count).to eq 5
      end

      it 'show all users count' do
        expect(assigns(:users).count).to eq 16
      end

      it 'show all replies count' do
        create(:reply)
        expect(assigns(:replies).count).to eq 1
      end
    end
  end

  context "#new" do
    # redirect to login page when user not sign in
    # render new when user sign in
    it 'redirect to login page when user not sign in' do
      get new_post_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'render new when user sign in' do
      sign_in(user)
      get new_post_path
      expect(response).to render_template(:new)
    end

  end

end