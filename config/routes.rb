Rails.application.routes.draw do
  devise_for :users

  get 'my_activities', to: 'recommendations#my_activities'
  root to: "categories#index"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :categories, only: %i[index show]
  resources :recommendations, only: %i[index show update]
end
