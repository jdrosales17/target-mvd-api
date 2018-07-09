Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    sessions: 'api/v1/sessions'
  }

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'auth/facebook', to: 'sessions#facebook'
      end
      resources :users, only: %i[update]
    end
  end
end
