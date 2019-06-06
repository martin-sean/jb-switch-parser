Rails.application.routes.draw do
  resources :games, only: [:create] do
    resources :prices, only: [:create]
  end

  root 'home#index'
  get '/refresh', to: 'home#refresh'
  post '/create', to: 'game#create'
end