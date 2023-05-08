Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :auction_lots, only: [:show, :new, :create, :update, :edit, :destroy] do
    patch :approve, on: :member
  end

  resources :product_models, only: [:index, :new, :create, :show, :update, :edit]
  resources :categories, only: [:create, :new]

end