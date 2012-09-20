Playround::Application.routes.draw do
  resources :rounds do
    resource :confirmations, :only => :create
    resource :subscription, :only => [:create, :destroy]
    resource :approvals, :only => :create
    resource :rejections, :only => :create
  end
  
  resources :arenas do
    get 'autocomplete_address', :on => :collection
  end

  resources :games
  
  resources :comments, :only => [:create, :destroy]
  
  resources :users do
    resource :quicktours, :only => [:update, :destroy]
  end

  resource :session, :controller => 'sessions'
  resource :locations, :only => :update
  
  match 'dashboards/:user_id' => 'dashboards#index', :as => 'dashboards'
  
  match 'sign_in' => 'sessions#new', :as => 'sign_in'
  match 'sign_out' => 'sessions#destroy', :via => :delete, :as => 'sign_out'

  root :to => 'pages#index'
end
