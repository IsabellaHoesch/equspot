Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  resources :places, only: [ :index, :new, :create, :show, :edit, :update ] do
    resources :favourites, only: [ :create ]
    resources :comments, only: [ :new, :create]
    resources :visits, only: [ :create ]
    resources :likes, only: [ :create ]
    resources :reviews, only: [ :new, :create, :destroy ]
  end
  resources :favourites, only: [ :index, :destroy ]
  resources :comments, only: [ :destroy ]

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
  resources :pages, only: [ :dashboard ]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
