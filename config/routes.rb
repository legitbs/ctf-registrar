Rails.application.routes.draw do
  get "scoreboard", to: 'scoreboard#index', as: :scoreboard
  get "scoreboard/challenge/:id", to: 'scoreboard#challenge', as: :challenge
  post "scoreboard/challenge/:id", to: 'scoreboard#answer'
  get "scoreboard/choice", to: 'picker#choice', as: :choice
  post "scoreboard/choice/:id", to: 'picker#pick', as: :pick
  get "scoreboard/categories", to: 'high_voltage/pages#show', id: 'categories', as: :categories
  get 'scoreboard/ctftime', format: :json
  get 'scoreboard/complete'

  get "notices", to: 'notices#index', as: :notices, format: :json

  get "notices/streamer", to: 'notices#streamer', format: :json

  get 'dashboard', to: 'dashboard#index', as: :dashboard

  root to: 'homepage#index', id: 'home'

  get '/api/hot', to: 'api#hot'

  resource :user
  resource :team
  resource :membership
  resources :resets
  resource :session do
    post 'token', on: :new
  end
  resource :token
  resources :achievements

  namespace :jarmandy do
    root to: 'root#index'
    resources :users
    resources :teams do
      member do
        post :kick
        post :wipe
        post :hot
        post :cool
      end
    end
    resources :notices
    resources :challenges do
      member do
        post :unlock
        post :lock
        post :solve
        post :unsolve
      end
    end
    resources :categories
  end
end
