Rails.application.routes.draw do
  match "/404" => "pages#error404", via: [ :get, :post, :patch, :delete ]

  devise_for :users, controllers: { registrations: "registrations" }
  devise_for :admins

  get    'carts'           => 'carts#index',   :constraints => { :format => 'json' }, :defaults => { :format => :json }
  post   'carts'           => 'carts#create',  :constraints => { :format => 'json' }, :defaults => { :format => :json }
  delete 'carts/:id'       => 'carts#destroy', :constraints => { :format => 'json' }, :defaults => { :format => :json }
  patch  'carts/plus/:id'  => 'carts#plus',    :constraints => { :format => 'json' }, :defaults => { :format => :json }
  patch  'carts/minus/:id' => 'carts#minus',   :constraints => { :format => 'json' }, :defaults => { :format => :json }

  get  'orders'     => 'orders#index',  :constraints => { :format => 'json' }, :defaults => { :format => :json }
  get  'orders/:uid' => 'orders#show',  :constraints => { :format => 'json' }, :defaults => { :format => :json }
  post 'orders'     => 'orders#create', :constraints => { :format => 'json' }, :defaults => { :format => :json }

  post 'orders/notify/:uid' => 'orders_notify#notify'
  get  'orders/return/:uid' => 'orders_notify#return'

  get   'profile' => 'profiles#show'
  get   'profile/edit' => 'profiles#edit'
  put   'profile' => 'profiles#update'
  patch 'profile' => 'profiles#update'

  get 'products/list' => 'products#list'
  get 'products/new' => 'products#new'
  get 'products/:title' => 'products#show'

  resources :messages
  resources :banners
  resources :images
  resources :news
  resources :products
  resources :products_images

  get '联系我们' => 'pages#contact'
  get '关于我们' => 'pages#about'
  get '常见问题' => 'pages#faq'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index', :defaults => { :format => :html }

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
  namespace :management do
    resources :orders
  end
end
