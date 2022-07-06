Rails.application.routes.draw do
  resources :products do
    collection do
      post :search
    end
    resources :comments
  end

  devise_for :users
  resources :cart_items
  resources :charges, only: [:create]

  get "/home", to:"pages#show", as: "home"

  patch 'cart_items/:id/update_item', to: 'cart_items#update_item' , as: :update_item
  delete 'cart_items/:id/delete_item', to: 'cart_items#delete_item', as: :delete_item

  patch 'cart_items/:id/increment_quantity_item', to: 'cart_items#increment_quantity_item' , as: :increment_quantity
  patch 'cart_items/:id/decrement_quantity_item', to: 'cart_items#decrement_quantity_item' , as: :decrement_quantity

  get '/charge', to: "charges#new"
  get '/search', to: "products#index"

  get 'apply_coupon', to: "coupons#apply_coupon"

  root to: "pages#show"

end
