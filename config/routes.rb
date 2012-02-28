StartAndWin::Application.routes.draw do

  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

########################### admin routes ###################
  scope :module => "admin" do
    match "/admin" => "admin_home#index", :as => :admin_root
  end

  namespace :admin do
    resources :news_points
    resources :main_categories
    resources :competitions
    resources :difficulty_level_settings, :only => [:index] do
      collection do
        post :update_all_settings
      end
    end
    resources :settings, :only => [:index]
    resources :questions do
      collection do
        post :multiple_upload
      end
    end
    get "admin_shared/load_subcategories"
    put "file_upload/async_private_upload"
  end
########################### end admin routes ###################

########################### cabinet for user routes ############
  namespace :cabinet do
    match 'main' => 'user_cabinet#index', :as => :user_root
    resources :questions do
      member do
        get :close_question
      end
    end
    resources :user_profile, :only => [:edit, :update, :show]
    resources :messages, :only => [:index, :show, :new, :create] do
      post :mark_as, :on => :collection
    end
  end
########################### end cabinet for user routes ########

###########################front routes######################
  scope :module => "front_end" do
    resources :questions, :only => [:index, :show] do
      member do
        get :start_play
        post :process_results
        post :set_rating_and_finish
      end
    end
  end
###########################end front routes###############


################ technical routes ####################
###autocomplete
  get 'autocomplete_user_login' => 'autocomplete#autocomplete_user_login'
###end autocomplete
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  get "signup" => "users#new", :as => "signup"
  put "image_uploader/async_upload_with_index"
  post "image_uploader/delete_image"
############### end technical routes ####################


  root :to => 'home#index'

  resources :users
  resources :user_sessions
  resources :password_resets
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
