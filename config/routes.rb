Rails.application.routes.draw do
  root to: 'customers#index'
  resources :customers

  get '/oders', to: 'oders#index'
  post '/orders', to: 'orders#create'
  get '/orders/new', to: 'orders#new', as: 'new_order' 
  get '/orders/:id', to: 'orders#show', as: 'order'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
