Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/signup" => "users#new"
    get "/signup" => "users#create"
    get "/login" => "sessions#new"
    post "login" => "sessions#create"
    delete "logout" => "sessions#destroy"
    resources :users
    resources :exams
    resources :exam_questions
    resources :subjects, only: :index
    resources :records, only: :create
    namespace :admin do
      root "admin_page#home"
      resources :users
      resources :subjects
    end
  end
end
