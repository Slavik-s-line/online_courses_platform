Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  resources :courses
  resources :users, only: [:index, :edit, :show, :update]
  root 'static_page#index'
  get '/static_page/index', to: 'static_page#index', as: :index
  get 'static_page/activity'
  
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
