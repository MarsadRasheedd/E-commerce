# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products do
    resources :comments
  end

  devise_for :users
  resources :cart_items, only: %i[index create]
  resources :charges, only: [:create]

  get '/home', to: 'pages#show', as: 'home'

  delete 'cart_items/:id/delete_item', to: 'cart_items#delete_item', as: :delete_item
  patch 'cart_items/:id/increment_quantity_item', to: 'cart_items#increment_quantity', as: :increment_quantity
  patch 'cart_items/:id/decrement_quantity_item', to: 'cart_items#decrement_quantity', as: :decrement_quantity

  get '/charge', to: 'charges#new'
  get '/search', to: 'pages#show'
  root to: 'pages#show'

  get 'apply_coupon', to: 'coupons#apply_coupon'

  match '*path', via: :all, to: 'pages#error_page', constraints: lambda { |request|
                                                                   request.path.exclude? 'rails/active_storage'
                                                                 }
end
