Rails.application.routes.draw do
  root "top_pages#top"
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
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
