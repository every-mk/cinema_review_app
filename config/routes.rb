Rails.application.routes.draw do
  get 'admins/guest_sign_in', to: 'admins#guest_sign_in'
  get 'users/guest_sign_in',  to: 'users#guest_sign_in'
  get 'users/account',        to: 'users#account'
  get 'celebrities/search',   to: 'celebrities#search'
  get 'cinemas/search',       to: 'cinemas#search'
  resource :users, only: [:destroy]

  scope '/users' do
    resource :profile, only: [:show, :update]
  end

  resources :celebrities, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :genres, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :cinemas, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :reviews, only: [:new, :create, :edit, :update]

  resources :admins, only: [:index]
  devise_for :admins, controllers: { registrations: 'admins/registrations', sessions: 'admins/sessions' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'cinemas#index'
end
