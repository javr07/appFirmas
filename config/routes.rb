Rails.application.routes.draw do

  resources :documents do
  	resources :signatures
  end
  
  devise_for :users
  authenticate :user do
  	root to: 'documents#index', as: :authenticated_root
  end
  root to: 'documents#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
