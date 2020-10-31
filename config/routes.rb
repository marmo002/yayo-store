Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#home"

  get "/pages/home", to: "pages#home"
  get "/pages/shop", to: "pages#shop"


  scope '/admin' do
    resources :types, except: [:show, :destroy]
    resources :brands, except: [:show]
    resources :brand_models
    resources :products, except: [:destroy]
    resources :colors, except: [:destroy]
    # resources :sizes
  end

end
