Rails.application.routes.draw do
  root 'welcome#index'

  # "Pretty" URLs for wholesalers and wholesale orders
  get 'wholesale' => 'wholesalers#select'#, as: :wholesalers_select
  devise_scope :wholesaler do
    get 'wholesale/log-in' => 'wholesaler_devise/sessions#new'#, as: :new_wholesaler_session
  end
  get 'wholesale/sign-up' => 'wholesalers#new'#, as: :new_wholesaler

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', sessions: 'sessions' }
  devise_for :wholesalers, controllers: { sessions: 'wholesaler_devise/sessions', passwords: 'wholesaler_devise/passwords'}

  delete 'identities/:provider' => 'admin/identities#destroy', as: :identity

  scope :w1, controller: 'w1', as: 'w1' do
    post :callback, action: 'callback'
    match 'success/:klass/:id', action: 'success', via: [:get, :post], as: :success
    match 'fail/:klass/:id', action: 'fail', via: [:get, :post], as: :fail
  end

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

  resources :items, only: [:index, :show] do
    resources :reviews, only: [:create], controller: 'item_reviews'
  end

  resources :pages, only: :show, path: :info do
    collection do
      get :company
      get :cosmetics
    end
  end
  resources :orders, only: [:new, :create] do
    get :payment, on: :member
    get :success, on: :member
    get :fail, on: :member
  end
  resources :wholesale_orders, only: [:new, :create] do
    get :payment, on: :member
    get :success, on: :member
    get :fail, on: :member
  end
  resources :reviews, only: [:create]
  resources :faqs, only: :index, path: 'faq', controller: 'faq'
  resources :questions, only: [:create, :index]
  resources :wholesalers, only: [:new, :create] do
    get :select, on: :collection
    get :pending, on: :collection
  end

  # Default cart
  post 'carts/items/:item_id' => 'carts#add', as: :add_to_cart
  delete 'carts/items/:item_id' => 'carts#remove', as: :remove_from_cart

  # Wholesale cart
  post 'wholesale_carts/items/:item_id' => 'wholesale_carts#add', as: :add_to_wholesale_cart


  namespace :cabinet do
    resources :orders, only: [:index, :new, :create] do
      get :payment, on: :member
      get :success, on: :member
      get :fail, on: :member
    end
    resource :profile, only: [:show, :update], controller: 'profile' do
      member do
        match 'update_password', to: 'profile#update_password', via: :patch
      end
    end
    post 'carts/items/:item_id' => 'carts#add', as: :add_to_cart
  end
end
