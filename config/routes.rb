Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index"

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  namespace :car do
    get '/registration', to: 'registration#index'
    get '/registration/register', to: 'registration#register'
  end

  scope :ethereum do
    get '/register_car', to: 'ethereum#register_car'
  end
end
