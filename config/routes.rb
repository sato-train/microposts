Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  resources :sessions, only: [ :new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :retweets, only: [:create, :destroy]

  resources :users do
    #memberメソッドでユーザーidを含むURLにそのルートが応答できるようにする
    member do
      #following_user_user_pathで指定するのは見苦しいので、followingとしている
      get :following, :followers
    end
  end
  
end
