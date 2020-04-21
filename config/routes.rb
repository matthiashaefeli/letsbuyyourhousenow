Rails.application.routes.draw do
  resources :resources
  resources :clients
  devise_for :users
  root 'home#index'
  get 'client/client_entries', to: 'clients#client_entries'
end
