Weedout::Application.routes.draw do
  get "response/index"
  devise_for :users

  get "/courses/select", to: 'courses#select'

  # namespaces suggestion comes from
  # http://guides.rubyonrails.org/routing.html
  # and
  # http://everydayrails.com/2012/07/31/rails-admin-panel-from-scratch.html
  namespace :professor do
    get "/courses/", to: 'courses#index'
    get "/courses/new", to: 'courses#create'
  end
  get "/reponse/", to: 'response#show'
  post "/response/create/", to: 'response#create'
  get "/test/new/:course_id", to: 'test#new', as: 'new_test'
  get "/test/show/:course", to: 'test#show', as: 'show_test'
  post "/test/create/:course_id", to: 'test#create', as: 'create_test'

  resources :courses

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # this is essentially overridden by the after_sign_in_path_for
  root "home#index"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
