Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :calendars do
    resources :events, shallow: true

    member do
      get :present
    end
  end

  get '/account', to: 'users#account', as: :account
  root to: 'home#index'
end
