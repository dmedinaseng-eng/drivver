Rails.application.routes.draw do
 root "landing#sellers"
 get "buyers", to: "landing#buyers"

 devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :os do
    root to: "dashboards#show"
    resource :dashboard, only: [ :show ]
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
