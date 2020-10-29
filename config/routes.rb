Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "pages#home"

  get "/pages/home", to: "pages#home"


  scope '/admin' do
    resources :types, only: [:index, :new, :edit, :create, :update]
    resources :brands, only: [:index, :new, :edit, :create, :update]
  end

end
