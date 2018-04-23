Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts do
    resources :replies, only: [:create, :edit, :update,:destroy]
  end

end
