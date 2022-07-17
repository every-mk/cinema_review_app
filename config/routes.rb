Rails.application.routes.draw do
  get 'users/account', to: 'users#account'

  scope '/users' do
    resource :profile, only: [:show, :update]
  end

  resources :admins, only: [:index]
  devise_for :admins, controllers: { registrations: 'admins/registrations', sessions: 'admins/sessions' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'users#index'
end
