Rails.application.routes.draw do
  get '/static_page/index', to: 'static_page#index', as: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
