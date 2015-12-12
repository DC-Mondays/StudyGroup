Rails.application.routes.draw do

  root to: "page#index"

  resources :users

end
