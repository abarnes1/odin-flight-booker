Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "flights#index"

  resources :flights, only: %w[index]
  resources :bookings, only: %w[index new show create]
end
