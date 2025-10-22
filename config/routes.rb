Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Hello World endpoint
      get 'hello', to: 'hello#index'
      
      resources :users do
        resources :posts, only: [:index]
        resources :comments, only: [:index]
      end
      
      resources :categories do
        resources :posts, only: [:index]
      end
      
      resources :posts do
        resources :comments, only: [:index, :create]
        member do
          post :add_tag
          delete :remove_tag
        end
      end
      
      resources :comments, only: [:show, :update, :destroy]
      resources :tags
    end
  end
  
  # Root endpoint - direkt localhost:3000 için
  root to: 'api/v1/hello#index'
  
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check
end