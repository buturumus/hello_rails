# config/routes.rb

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get "/movies", to: "movies#index"
  # get "/movies/:id", to: "movies#show"

  # Defines the root path route ("/")
  root "movies#index"
  resources :movies do
    get "/page/:page", action: :index, on: :collection 
    resources :ratings
    collection do
      get "panel" 
    end
  end
  resources :categories do
    collection do
      get "panel" 
    end
  end
end
