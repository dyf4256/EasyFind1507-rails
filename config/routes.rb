Rails.application.routes.draw do
  devise_for :users

  get 'my_activities', to: 'recommendations#my_activities'
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  
  resources :recommendations, only: %i[index show update]
end
