Rails.application.routes.draw do
  devise_for :people, controllers:{registrations: 'people/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'books/viewallbooks'
  get 'orders/order_detail'
  # get 'addresses/confirm_order'
  root to: 'books#index'
  get 'final_confirm/:id' => 'orders#final_confirm', as: :final_confirm
  get 'final_confirm_to_current_person/:id' => 'orders#final_confirm', as: :final_confirm_to_current_person
 
  get 'confirm_order/:id/' => 'addresses#confirm_order', as: :confirm_order
  get 'viewaddress/:id/' => 'addresses#viewaddress', as: :viewaddress
  get 'cities/:state', to: 'application#cities'

  get 'addresses/addnew'
  get 'addresses/change_city'
  get 'books/near_by_me' => 'books#near_by_me', as: :near_by_me
  resources :categories
  resources :books
  resources :addresses
  resources :orders
  resources :charges
  resources :notifications do
    collection do
      post :mark_as_read 
    end
  end
  
  resources :books do 
    resources :addresses do
      get 'confirm_order'
    end
  end
  



end