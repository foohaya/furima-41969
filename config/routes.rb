Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'items#index'
  
  resources :items do
    resources :orders, only: [:index, :create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
