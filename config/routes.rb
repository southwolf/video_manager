Rails.application.routes.draw do
  mount OkComputer::Engine, at: '/health'

  resources :videos, except: [:index]
end
