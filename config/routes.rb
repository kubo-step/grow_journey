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

  resources :goals do
    member do
      patch :toggle
    end
    collection do
      get :completed_goals
    end
    resources :tasks, shallow: true
  end

  resources :tasks, only: [] do
    member do
      patch :toggle
      post :copy
    end
  end

  resources :goal_steps, only: [:show, :update]
  resources :categories, only: %i[new create]
  resource :profiles, only: %i[show edit update]

  get "flowers", to: "flower#index"

  # 開発環境限定のルーティング
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
