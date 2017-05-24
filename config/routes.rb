Rails.application.routes.draw do
  get 'geocodes/index'

  resources :geocodes
  root 'geocodes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :geocodes
  root 'geocodes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end