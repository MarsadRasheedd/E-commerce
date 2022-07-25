# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products do
    resources :comments
    get :public_products, on: :collection
  end

  devise_for :users
  resources :cart_items
  resources :charges, only: [:create]

  get '/charge', to: 'charges#new'
  root to: 'products#public_products'
  get 'apply_coupon', to: 'coupons#apply_coupon'
  match '*path', via: :all, to: 'products#error_page', constraints: lambda { |request|
                                                                      request.path.exclude? 'rails/active_storage'
                                                                    }
end
