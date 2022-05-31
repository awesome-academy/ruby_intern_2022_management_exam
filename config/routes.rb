Rails.application.routes.draw do
  scope (":locale"), locale: /en|vi/ do
    root "static_pages#home"
    get "/signup" => "users#new"
    get "/signup" => "users#create"
    get "/login" => "sessions#new"
    post "login" => "sessions#create"
    delete "logout" => "sessions#destroy"
    resources :users
    resources :subjects, only: :index

    namespace :admin do
      get "/", to: "admin_page#home"
    end
  end
end
