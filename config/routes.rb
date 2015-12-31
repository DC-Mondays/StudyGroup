Rails.application.routes.draw do

  root to: "page#index"

  resources :users
  resources :session
  post "/confirm/:token", to: "users#confirm"
  get "/login", to: "session#new"
  get "page/user_home"

end
