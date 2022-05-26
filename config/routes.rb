Rails.application.routes.draw do
  root "static_pages#home"
  scope :locale, locale: /en|vi/ do
    get "/signup" => "users#new"
    get "/signup" => "users#create"
    get "/login" => "sessions#new"
    post "login" => "sessions#create"
    delete "logout" => "sessions#destroy"
    resources :users
    resources :subjects, only: :index
  end
end
