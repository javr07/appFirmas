Rails.application.routes.draw do

  get 'chats/index' => 'chats#index', as: :chats
  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end
  
  devise_for :users
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  patch 'documents/document_user_upload' => 'documents#document_user_upload', as: :document_user_upload
  get 'documents/allshared' => 'documents#allshared', as: :documents_shared
  
  resources :documents

  authenticate :user do
  	root to: 'documents#index', as: :authenticated_root
  end

  resources :documents do
  	resources :signatures
  end
  root to: 'documents#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
