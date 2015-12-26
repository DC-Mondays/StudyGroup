Rails.application.routes.draw do

  root to: "page#index"

  resources :users
  post "/confirm/:token", to: "users#confirm"

end
