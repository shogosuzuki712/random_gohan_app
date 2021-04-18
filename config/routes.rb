Rails.application.routes.draw do
  devise_for :users
  root to: "tweets#index"
  resources :tweets, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only: :show
end
