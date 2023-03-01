Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :cars
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :cars do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :destroy, :edit, :update]
  get "your_cars", to: "cars#your_cars", as: :users_cars
  get "your_car_bookings", to: "cars#your_car_bookings", as: :users_cars_bookings
end
