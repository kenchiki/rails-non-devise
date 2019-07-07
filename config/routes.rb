Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :sessions, only: %i[new create destroy]
end
