Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users

  namespace :admin do
    root 'items#index'
    resources :pages, except: :show
    resources :items, except: :show

    superb_text_constructor_for :pages
    superb_text_constructor_for :items
  end

  resources :items, only: [:index, :show]
  resources :pages, only: :show, path: :info do
    collection do
      get :company
    end
  end
  resources :orders, only: [:new]

  post 'carts/items/:item_id' => 'carts#add', as: :add_to_cart
  delete 'carts/items/:item_id' => 'carts#remove', as: :remove_from_cart
end
