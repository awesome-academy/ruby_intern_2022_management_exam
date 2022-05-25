Rails.application.routes.draw do
  scope :locale, locale: /en|vi/ do
    root "static_pages#home"
    get "/signup" => "users#new"
    get "/signup" => "users#create"
    get "/login" => "sessions#new"
    post "login" => "sessions#create"
    delete "logout" => "sessions#destroy"
    resources :users
  end
end
