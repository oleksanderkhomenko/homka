Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root to: "home#index"
  resources :albums do
    resources :photos, only: [:new, :create, :show, :destroy]
  end
  resources :photos, only: [:index, :show, :destroy]
  resource :search, only: [:show]
  get 'user/:username', to: 'users#show', as: 'user'
  get 'user/:username/:album_id', to: 'users#show_album', as: 'user_album'
  resources :subscriptions, only: [:create, :destroy]
end
