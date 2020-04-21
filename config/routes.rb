Rails.application.routes.draw do
  resources :resources
  resources :clients
  devise_for :users
  root 'home#index'
  get 'home/login', to: 'home#login'
  get 'client/client_entries', to: 'clients#client_entries'
end
