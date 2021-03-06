Rails.application.routes.draw do

  resources :opravas

  resources :organizators

  resources :riesitel_seria do
    collection do
      get :riesitelia_serie
      post :edit_riesitels
    end
  end

  resources :riesitels do
    collection do
      post :add_riesitels
      post :add_riesitels_to_seria
    end
  end

  resources :homepages do
    collection do
      get :login
      post :login
    end
  end

  root "homepages#login"

  resources :komentars

  resources :priklads do
    member do
      get :edit_priklad
      patch :edit_priklad
    end
  end

  resources :kolos do
    member do
      post :add_priklads
      delete :remove_priklad
    end
  end

  resources :knizkas do
    member do
      post :add_obsah
      delete :remove_obsah
      get :zadania
      get :zadania_edit
      post :zadania_edit
      patch :zadania_edit
      get :vzoraky
      get :vysledkovka
      get :clanok
      post :gen_pdf
    end
  end

  resources :seria do
    resources :knizkas
  end

  resources :rocniks

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
