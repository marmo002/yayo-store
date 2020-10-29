Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#home"

  get "/pages/home", to: "pages#home"


  scope '/admin' do
    resources :types, except: [:show, :destroy]
    resources :brands, except: [:show] do
      resources :brand_models, only: [:index, :new, :create, :show]
    end
  end

end
