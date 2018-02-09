Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :albums do
    resources :photos, only: [:new, :create, :show, :destroy]
  end
  resources :photos, only: [:index, :show, :destroy]
end
