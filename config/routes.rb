Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :categories, :only => [:index, :show]
  resources :recipes, :only => [:index, :show]

  root to: "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
