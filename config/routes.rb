Rails.application.routes.draw do
  resources :games
  resources :players
  resources :sessions, only: [:create, :destroy, :new] 
  resources :teams
  resources :tables
  resources :search, only: [:index]
  resources :slack_webhooks, only: [:create]


  get '/signup', to: 'players#new'
  get '/login', to: 'sessions#new', as: 'log_in'
  get '/logout', to: 'sessions#destroy', as: 'log_out'

  root to: 'home#index'

  get '/rankings', to: 'players#rankings'

end
