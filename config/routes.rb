Rails.application.routes.draw do
  root to: "welcome#index"
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
end
