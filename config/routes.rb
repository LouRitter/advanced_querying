Rails.application.routes.draw do
  resources :locations
  resources :roles
  resources :people
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
