Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  health_check_routes

  resources :highchart, only: [:index] do
    collection do
      get ":city", to: "highchart#index"
    end
  end
end
