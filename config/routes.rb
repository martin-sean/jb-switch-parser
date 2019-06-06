Rails.application.routes.draw do
  root 'home#index'
  get '/refresh', to: 'home#refresh'
end