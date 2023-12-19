Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root "top_pages#top"
  get "privacy_policy", to: "top_pages#privacy_policy"
  get "terms", to: "top_pages#terms"

  get "flowers", to: "flower#index"
  resources :goals do
    member do
      patch :toggle
    end
    collection do
      get :completed_goals
    end
  end

  resources :goal_steps, only: [:show, :update]
  resources :categories, only: %i[new create]
  resource :profiles, only: %i[show edit update]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
