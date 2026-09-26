Rails.application.routes.draw do
 root "landing#sellers"
 get "buyers", to: "landing#buyers"

 devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :os do
    root to: "dashboards#show"
    resource :dashboard, only: [ :show ]
    resource :settings, only: [:show, :update]

    post "switch_context", to: "base#switch_context", as: :switch_context
  end

  namespace :admin do
    resources :effective_roles, only: [:create]
  end

  namespace :users do
    post "auth/google_id_token", to: "google_id_tokens#create", as: :google_id_token

    resources :passkeys, only: [ :index, :create, :destroy ] do
      collection do
        post :callback
        post :authenticate_options
        post :authenticate
      end
    end
  end
end
