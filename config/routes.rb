Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :places, only: [ :index, :new, :create, :show, :edit, :update ] do
    resources :favourites, only: [ :create ]
    resources :comments, only: [ :new, :create]
    resources :visits, only: [ :create ]
  end
  resources :favourites, only: [ :index, :destroy ]
  resources :comments, only: [ :destroy ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
