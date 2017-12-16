Rails.application.routes.draw do
  root to: "welcome#index"
  resources :questions, only: [:new, :create, :show]
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
end
