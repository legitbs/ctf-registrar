CtfRegistrar::Application.routes.draw do
  get "scoreboard", to: 'scoreboard#index', as: :scoreboard
  get "scoreboard/challenge/:id", to: 'scoreboard#challenge', as: :challenge
  post "scoreboard/challenge/:id", to: 'scoreboard#answer'
  get "scoreboard/choice", to: 'picker#choice', as: :choice
  post "scoreboard/choice/:id", to: 'picker#pick', as: :pick
  get "scoreboard/categories", to: 'high_voltage/pages#show', id: 'categories', as: :categories

  get "notices", to: 'notices#index', as: :notices, format: :json

  get "notices/tyaHaumBeidOlNasvephAnsayWraryucBiegcov5", to: 'notices#streamer', format: :json

  get 'dashboard', to: 'dashboard#index', as: :dashboard

  root to: 'homepage#index', id: 'home'

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
