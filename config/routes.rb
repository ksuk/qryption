Rails.application.routes.draw do
  root to: 'questions#index'
  resource :welcome, only: [:index]
  resources :questions, only: [:new, :create, :show]
  resources :answers, only: [:create]
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
end
