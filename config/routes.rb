Rails.application.routes.draw do
  devise_for :users
  
  authenticated :user do
    root 'pages#home', as: :authenticated_root
  end
  
  root 'pages#guest'
  
  get 'home', to: 'pages#home'
  get 'guest', to: 'pages#guest'
  
  get "up" => "rails/health#show", as: :rails_health_check
  resources :profiles, except: [:index, :destroy]
end