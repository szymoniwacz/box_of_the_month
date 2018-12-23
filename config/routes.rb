Rails.application.routes.draw do
  match '/', to: 'application#info', via: [:get]
  # match '/', to: 'application#routing_not_found', via: [:post, :put]

  namespace :v1 do
    resources :customers, only: %i[show create]
    resources :subscriptions, only: %i[show create] do
      post :cancel
    end
    resources :plans, only: [:index]
    resources :payments, only: [:show]
  end
end
