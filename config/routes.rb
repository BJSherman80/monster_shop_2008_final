Rails.application.routes.draw do
  root 'welcome#index'

  resources :merchants do
     resources :items, only: [:index, :new, :create]
  end

  resources :items, except: [:new, :create] do
    resources :reviews, only: [:new, :create]
  end

  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  resources :orders, only: [:new, :create, :show]
  # users
  get '/register', to: "users#new"
  post '/register', to: "users#create"
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  patch '/profile', to: 'users#update'
  get '/profile/orders', to: 'users_orders#index'
  get '/profile/orders/:id', to: 'orders#show'
  patch '/profile/orders/:id', to: 'orders#update'
  # password
  get '/password/edit', to: 'password#edit'
  patch '/password', to: 'password#update'
  # sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/', to: 'sessions#destroy'
  # cart
  post "/cart/:item_id", to: "cart#add_item"
  patch "/cart/:item_id/increment", to: "cart#increment"
  patch "/cart/:item_id/decrement", to: "cart#decrement"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  namespace :admin do
    resources :merchants, only: [:index, :show, :update]
    get '/', to: 'dashboard#index'
    get '/users', to: 'users_dashboard#index'
    get '/users/:id', to: 'users_dashboard#show'
    patch '/users/:id/orders/:order_id', to:'users_dashboard#update'
  end

  namespace :merchant do
    get '/', to: 'dashboard#show'
    resources :items
    resources :item_orders, only: [:update]
    resources :orders, only: [:show]
    resources :discounts
    patch '/discounts/:id/edit', to: 'discounts#edit'
    delete '/discounts/:id/delete', to: 'discounts#destroy'
  end
end
