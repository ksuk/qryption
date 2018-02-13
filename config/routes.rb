Rails.application.routes.draw do
  root to: 'questions#index'
  resources :top, only: :index
  resources :questions, only: [:new, :create, :show]
  resources :answers, only: [:create]
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
  }, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
end
