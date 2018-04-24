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
  end

  resources :users, only: [:show, :edit, :update] do
    member do 
      post :invite
    end
  end

end
