Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :auction_lots, only: [:show, :new, :create, :update, :edit, :destroy] do
    resources :bids, only: [:index, :new, :create]
    patch :approve, on: :member
    patch :close_or_cancel, on: :member
    post :add_product, on: :member
    delete :remove_product, on: :member
    get :expired, on: :collection
    get :winner, on: :collection
  end

  resources :product_models, only: [:index, :new, :create, :show, :update, :edit]
  resources :categories, only: [:create, :new]
  resources :products, only: [:create, :new]

end