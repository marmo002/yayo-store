Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#home"

  get "/pages/home", to: "pages#home"
  get "/pages/shop", to: "pages#shop"


  scope '/admin' do
    get "/authenticate", to: "admin_registrations#new"
    post "/authenticate", to: "admin_registrations#create"
    get "/registration", to: "admin_registrations#edit"
    patch "/registration", to: "admin_registrations#update"
    
    get '/login', to: 'admin_sessions#new', as: :login
    delete '/logout', to: 'admin_sessions#destroy', as: :logout
    resources :admin_sessions, only: [:create]
    
    resources :admins, except: [:show, :destroy]
    post "/code_resend/:id", to: "admins#resend_ref_code", as: :code_resend
    resources :types, except: [:show, :destroy]
    resources :brands, except: [:show]
    resources :brand_models
    resources :products, except: [:destroy]
    resources :colors, except: [:destroy]
    resources :sizes, except: [:show, :destroy]
  end

end
