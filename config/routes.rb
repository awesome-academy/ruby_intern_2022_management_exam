Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root "static_pages#home"
    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
      get "/signup", to: "devise/registration#new"
    end
    resources :users
    resources :exams
    resources :exam_questions
    resources :subjects, only: :index
    resources :records, only: :create
    namespace :admin do
      root "admin_page#home"
      resources :users
      resources :subjects
      resources :questions
    end
  end
end
