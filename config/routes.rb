Rails.application.routes.draw do
  mount OkComputer::Engine, at: '/health'
end
