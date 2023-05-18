Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index] do
    patch 'block', on: :member
    patch 'unblock', on: :member
    post 'block_cpf', on: :member
  end
  
  resources :blocked_cpfs, only: [:create] do
    delete :destroy, on: :member
  end


  root to: 'home#index'

  resources :auction_lots, only: [:show, :new, :create, :update, :edit, :destroy] do
    resources :bids, only: [:index, :new, :create]
    resources :questions, only: [:new, :create]
    get :question_lot, on: :member
    patch :approve, on: :member
    patch :close_or_cancel, on: :member
    post :add_product, on: :member
    delete :remove_product, on: :member
    get :expired, on: :collection
    get :winner, on: :collection
    post :favorite, on: :member
    delete :unfavorite, on: :member
    get :favorites, on: :collection
  end

  resources :questions, only: [:index, :show, :edit, :update] do
    patch :hide, on: :member
  end
  resources :product_models, only: [:index, :new, :create, :show, :update, :edit]
  resources :categories, only: [:create, :new, :edit, :update, :index]
  resources :products, only: [:create, :new]

end