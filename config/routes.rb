Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users, only: [:index]
  root 'static_page#index'
  get '/static_page/index', to: 'static_page#index', as: :index
  get 'static_page/activity'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
