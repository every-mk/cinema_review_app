Rails.application.routes.draw do
  get 'admins/guest_sign_in', to: 'admins#guest_sign_in'
  get 'users/guest_sign_in', to: 'users#guest_sign_in'
  get 'users/account',       to: 'users#account'
  resource :users, only: [:destroy]

  scope '/users' do
    resource :profile, only: [:show, :update]
  end

  resources :admins, only: [:index]
  devise_for :admins, controllers: { registrations: 'admins/registrations', sessions: 'admins/sessions' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'users#index'
end
