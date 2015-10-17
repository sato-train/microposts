Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  resources :sessions, only: [ :new, :create, :destroy]
  resources :users
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
