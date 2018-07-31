Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    sessions: 'api/v1/sessions'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_scope :user do
        post 'auth/facebook', to: 'sessions#facebook'
      end
      resources :users, only: %i[update]
      resources :topics, only: %i[index]
      resources :targets, only: %i[index create destroy]
      resources :devices, only: %i[create]
      post '/questions', to: 'questions#create'
      get '/compatible_users', to: 'compatible_users#index'
      resources :conversations, only: [] do
        resources :messages, only: %i[index]
      end
    end
  end
end
