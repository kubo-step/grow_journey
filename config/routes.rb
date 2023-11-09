Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }

  root "top_pages#top"

  get 'flowers', to: 'users#flowers'
  resources :goals do
    member do
      patch :toggle
    end
    collection do
      get  :completed_goals
    end
  end
  resources :categories, only: %i[new create]
  resource :profiles, only: %i[show edit update]
end
