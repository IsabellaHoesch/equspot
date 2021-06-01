Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :places, only: [ :index, :new, :create, :show, :edit, :update ] do
    resources :favourites, only: [ :create ]
  end
  resources :favourites, only: [ :index ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
