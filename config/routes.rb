CtfRegistrar::Application.routes.draw do
  get "resets/index"
  get "resets/new"
  get "resets/edit"
  get "scoreboard", to: 'scoreboard#index', as: :scoreboard
  get "scoreboard/challenge/:id", to: 'scoreboard#challenge', as: :challenge
  post "scoreboard/challenge/:id", to: 'scoreboard#answer'
  get "scoreboard/choice", to: 'picker#choice', as: :choice
  post "scoreboard/choice/:id", to: 'picker#pick', as: :pick

  get "notices", to: 'notices#index', as: :notices, format: :json

  get 'dashboard', to: 'dashboard#index', as: :dashboard

  root to: 'homepage#index', id: 'home'

  resource :user
  resource :team
  resource :membership
  resource :session do
    post 'token', on: :new
  end
  resource :tokens

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
