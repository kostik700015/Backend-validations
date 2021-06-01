Rails.application.routes.draw do
  get '/oders', to: 'oders#index'
  post '/orders', to: 'orders#create'
  get '/orders/new', to: 'orders#new', as: 'new_order' 
  get '/orders/:id', to: 'orders#show', as: 'order'  
end
