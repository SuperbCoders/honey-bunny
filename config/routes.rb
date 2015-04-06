Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', sessions: 'sessions' }
  devise_for :wholesalers, controllers: { sessions: 'wholesaler_devise/sessions' }

  delete 'identities/:provider' => 'admin/identities#destroy', as: :identity

  namespace :admin do
    root 'orders#index', workflow_state: 'new'
    resources :pages, except: :show
    resources :items, except: [:show] do
      patch :restore, on: :member
    end
    resources :orders, except: [:show, :destroy] do
      resources :order_items, except: [:index, :show]
      member do
        patch :ship
        patch :deliver
        patch :cancel
      end
    end
    resources :wholesale_orders, except: [:show, :destroy] do
      resources :order_items, except: [:index, :show]
      member do
        patch :ship
        patch :deliver
        patch :cancel
      end
    end
    resources :shipping_methods, except: [:show, :destroy] do
      resources :shipping_prices, only: [:create, :destroy]
    end
    resources :shops, except: :show
    resources :reviews, except: :show do
      member do
        patch :approve
        patch :decline
      end
    end
    resources :users, except: :show
    resources :wholesalers, except: :show do
      member do
        patch :approve
        patch :decline
      end
    end
    resources :faqs, except: :show, path: 'faq', controller: 'faq' do
      post :up, on: :member
      post :down, on: :member
    end
    resources :questions, only: :index do
      member do
        patch :archive
        patch :restore
      end
    end
    resources :settings, only: :index do
      patch :update_meta_block, on: :collection
    end

    superb_text_constructor_for :pages
    superb_text_constructor_for :items
  end

  resources :items, only: [:index, :show]
  resources :pages, only: :show, path: :info do
    collection do
      get :company
      get :cosmetics
    end
  end
  resources :orders, only: [:new, :create] do
    get :success, on: :member
  end
  resources :wholesale_orders, only: [:new, :create] do
    get :success, on: :member
  end
  resources :reviews, only: [:create]
  resources :faqs, only: :index, path: 'faq', controller: 'faq'
  resources :questions, only: :create
  resources :wholesalers, only: [:new, :create] do
    get :select, on: :collection
    get :pending, on: :collection
  end

  # Default cart
  post 'carts/items/:item_id' => 'carts#add', as: :add_to_cart
  delete 'carts/items/:item_id' => 'carts#remove', as: :remove_from_cart

  # Wholesale cart
  post 'wholesale_carts/items/:item_id' => 'wholesale_carts#add', as: :add_to_wholesale_cart
end
