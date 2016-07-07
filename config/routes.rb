Rails.application.routes.draw do
  devise_for :user

  devise_scope :user do
   root to: "devise/sessions#new"
  end

  resources :ingredients
  resources :recipe, only: [:index]
end
