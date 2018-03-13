Rails.application.routes.draw do
  resources :coins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#welcome'

  resources :users
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: 'destroy_user'
  get '/auth/:provider/callback' => 'sessions#create'

  resources :coins
  post 'coins/refresh' => 'coins#update_coin_list', as: 'update_coin_list'

  resources :portfolios do
    resources :transactions
  end

end
