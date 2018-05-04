Rails.application.routes.draw do
  resources :friend_requests, only: [:create, :update, :destroy]

  devise_for :users

  root 'posts#index'

  resources :posts do
    resources :replies, only: [:create, :edit, :update,:destroy]
    member do 
      post :collect
      post :uncollect
    end

    collection do
      get :feed
    end
  end

  resources :users, only: [:show, :edit, :update] do
    member do 
      post :invite
    end
  end

  # 後台
  namespace :admin do
    resources :categories
    resources :users, only: [:index, :update]
  end

  # API 
  namespace :api, default: {format: :json} do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create, :update, :destroy]
    end
  end

end
