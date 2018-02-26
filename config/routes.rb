Rails.application.routes.draw do
  root to: 'questions#index'
  resources :top, only: :index
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end
  resources :questions, only: [:new, :create, :show]
  resources :answers, only: [:new, :create]
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
  }, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
end
