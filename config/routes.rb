Rails.application.routes.draw do
  root to: "pages#home"
  resources :cars, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
