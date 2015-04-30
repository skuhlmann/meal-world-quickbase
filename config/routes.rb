Rails.application.routes.draw do
  root 'meals#index'

  resources :meals, only: [:index, :show]
end
