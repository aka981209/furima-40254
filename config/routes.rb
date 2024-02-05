Rails.application.routes.draw do
  devise_for :users
  get 'items/index'

  root 'items#index'
  resources :items do
    resources :orders, only: [:index, :new, :create]
  end
  
end
