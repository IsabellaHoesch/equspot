Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  get 'profile', to: 'pages#profile', as: :profile
  get 'about', to: 'pages#about', as: :about
  get 'contact', to: 'pages#contact', as: :contact
  resources :places, only: [ :index, :new, :create, :show, :edit, :update ] do
    resources :favourites, only: [ :create ]
    resources :visits, only: [ :create ]
    resources :reviews, only: [ :new, :create, :destroy ]
  end
  resources :favourites, only: [ :index, :destroy ]

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
