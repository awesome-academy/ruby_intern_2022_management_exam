Rails.application.routes.draw do
  root "subjects#show"
  scope :locale, locale: /en|vi/ do
    get "/signup" => "users#new"
    get "/signup" => "users#create"
    get "/login" => "sessions#new"
    post "login" => "sessions#create"
    delete "logout" => "sessions#destroy"
    resources :users
  end
end
