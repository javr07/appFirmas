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

  patch 'documents/verifySignature' => 'documents#verifySignature', as: :documents_verifySignature
  get 'documents/sign' => 'documents#sign', as: :documents_sign
  patch 'documents/document_user_upload' => 'documents#document_user_upload', as: :document_user_upload
  get 'documents/allshared' => 'documents#allshared', as: :documents_shared

  authenticate :user do
  	root to: 'documents#index', as: :authenticated_root
  end

  get 'signatures/new' => 'signatures#new', as: :signatures_new
  get 'signatures/download' => 'signatures#download', as: :signatures_download

  resources :documents
  resources :signatures, only: [:create, :new]

  root to: 'documents#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
