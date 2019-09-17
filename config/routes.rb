Rails.application.routes.draw do
  resources :games, only: :show
  root 'home#index'
  get '/refresh', to: 'home#refresh'
end
