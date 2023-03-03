Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :cars
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :cars do
    resources :bookings, only: [:new, :create]
    resources :reviews, only: :create
  end

  resources :bookings, only: [:index, :destroy, :edit, :update]
  patch "bookings/:id/accept", to: "bookings#accept", as: :accept_booking
  patch "bookings/:id/decline", to: "bookings#decline", as: :decline_booking
  get "your_cars", to: "cars#your_cars", as: :users_cars
  get "your_car_bookings", to: "cars#your_car_bookings", as: :users_cars_bookings
end
