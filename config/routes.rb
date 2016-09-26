PushvendorPos::Application.routes.draw do
  get "histcotes/index"
  resources :purchaseorders

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :item_categories

  resources :reports do
    collection do
      get 'total_report'
      get 'date_range_report'
      get 'customer_report'
      get 'item_report'
    end
  end

  resources :line_items

  resources :payments do
    collection do
      get 'make_payment'
    end
  end

  resources :employees do
    collection do
      get 'make_payment'
    end
  end

  resources :retails do
    collection do
      get 'make_payment'
    end
  end

  resources :configurations do 
    collection do 
      get 'update'
    end
  end

  resources :customers
   resources :histosale
   resources :histcotes

  resources :items do
    collection do
     get 'search'
     get  'dupp' 
     get :autocomplete_item_name
 
    end
  end

   
       
  resources :sales do
    collection do
      get 'update_line_item_options'
      get 'update_customer_options'
      get 'create_line_item'
      get 'update_totals'
      get 'add_item'
      get 'descuento'
      get 'remove_item'
      get 'removeperson'
      get 'create_customer_association'
      get 'create_employee_association'
      get 'create_custom_item'
      get 'create_custom_customer'
      get 'add_comment'
      post 'override_price'
      post 'sale_discount'
      get  'search'
      get  'uno' 
      get 'refreca'
      get 'los'
      get 'setsale'
      get 'pagidor'
      post 'dup'
      get 'suma'
    

    end
  end

  resources :dashboard do
    collection do
      get 'create_sale_with_product'
      get 'dup'

    end
  end

  #resources :cash_outs

  resources :cash_outs do
    collection do
      get 'dame'
      get 'cortes'
    end
  end

  devise_for :users
  resources :users do
    collection do
      post 'new_user'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sales#new'

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
