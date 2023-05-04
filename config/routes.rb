Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :product_models, only: [:index]
end
