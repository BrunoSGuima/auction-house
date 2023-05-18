Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index] do
    member do
      patch :block
      patch :unblock
      post :block_cpf
    end
  end
  
  
  resources :blocked_cpfs, only: [:create] do
    delete :destroy, on: :member
  end


  root to: 'home#index'

  resources :auction_lots, only: [:show, :new, :create, :update, :edit, :destroy] do
    member do
      get :question_lot
      patch :approve
      patch :close_or_cancel
      post :add_product
      delete :remove_product
      post :favorite
      delete :unfavorite
    end

    collection do
      get :expired
      get :winner
      get :favorites
      get :search
    end

    resources :bids, only: [:index, :new, :create]
    resources :questions, only: [:new, :create]
  end

  resources :questions, only: [:index, :show, :edit, :update] do
    patch :hide, on: :member
  end

  resources :product_models, only: [:index, :new, :create, :show, :update, :edit]
  resources :categories, only: [:create, :new, :edit, :update, :index]
  resources :products, only: [:create, :new]

end