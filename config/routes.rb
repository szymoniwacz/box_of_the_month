Rails.application.routes.draw do
  match '/', to: 'application#info', via: [:get]
  # match '/', to: 'application#routing_not_found', via: [:post, :put]

  namespace :v1 do
    resources :subscriptions, only: [:create]
  end
end
