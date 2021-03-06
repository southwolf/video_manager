Rails.application.routes.draw do
  mount OkComputer::Engine, at: '/health'

  resources :videos, except: [:index]
  resources :comments, except: [:index]

  get '/comments', to: 'comments#show_for_video'
end
