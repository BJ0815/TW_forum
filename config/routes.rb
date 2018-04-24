Rails.application.routes.draw do
  get 'users/show'

  devise_for :users

  root 'posts#index'

  resources :posts do
    resources :replies, only: [:create, :edit, :update,:destroy]
    member do 
      post :collect
      post :uncollect
    end
  end

  resources :users, only: [:show, :edit, :update]

end
