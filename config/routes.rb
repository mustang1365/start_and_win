StartAndWin::Application.routes.draw do


  root :to => 'home#index'

  #admin part
  scope :module => "admin" do
    get "admin_home", :to => "admin_home#index", :as => :my_admin_root
    resources :roles do
      get :ajax_load_permissions
    end
    resources :users do
       get :toggle_user_active_status_users
    end
    resources :news_points
  end

  #ROUTES WITHOUT NAMESPACE
      match '/profile' => "profiles#show"

      resources :profiles, :only =>[:edit, :update]

      put "files/upload_file"

  #device settings and overrides
  devise_for :users
  devise_scope :user do
    get "sign_in", :to => "user_sessions#new"
    post "sign_in", :to => "user_sessions#create"
    get "sign_out", :to => "user_sessions#destroy"
    get "sign_up", :to => 'users#new'
    post "sign_up", :to => 'users#create'
    get "confirmation", :to => "my_confirmations#show"
  end


  namespace :admin do
    root :to => 'users#index'

  end
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
  # match ':controller(/:action(/:id(.:format)))'
end
