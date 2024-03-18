Rails.application.routes.draw do
  devise_for :users

  get 'my_activities', to: 'recommendations#my_activities'
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
  resources :categories, only: %i[index]
  resources :recommendations, only: %i[index show new create update]
  resources :session, only: %i[create]
  get 'recommendations/:id/details', to: 'recommendations#details', as: :details

end
