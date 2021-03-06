Rails.application.routes.draw do
  resources :resources
  resources :clients
  resources :page_view_results
  devise_for :users
  root 'home#index'
  get 'home/login', to: 'home#login'
  get 'client/client_entries', to: 'clients#client_entries'
  get 'client/show_images/:id', to: 'clients#show_images', as: 'client_show_images'
  get 'client/delete_image/:id', to: 'clients#delete_image', as: 'delete_image'
  get 'client/show_image/:id', to: 'clients#show_image', as: 'show_image'
end
