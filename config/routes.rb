Rails.application.routes.draw do
  resources :resources
  resources :clients
  resources :page_view_results
  devise_for :users
  root 'home#index'
  get 'home/login', to: 'home#login'
  get 'client/client_entries', to: 'clients#client_entries'
  get 'client/show_images/:id', to: 'clients#show_images'
end
