Rails.application.routes.draw do

  devise_for :users
  get 'checkout/new(/:movie_id)', to: 'checkouts#new', as: 'new_checkout'
  post 'checkouts(/:movie_id)', to: 'checkouts#create', as: 'checkouts'
  
  resources :movies
  resources :checkouts
  root 'movies#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
