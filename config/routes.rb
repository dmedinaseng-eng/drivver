Rails.application.routes.draw do
 root "landing#sellers"
 get "buyers", to: "landing#buyers"

 devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  namespace :os do
    root to: "dashboards#show"
    resource :dashboard, only: [:show]
  end
end
