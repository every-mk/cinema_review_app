Rails.application.routes.draw do
  
  get 'users/show'

  scope '/users' do
    # resource :profile, only: [:show, :update]
    resource :profile, only: [:update]
  end

  resources :admins, only: [:index]
  devise_for :admins, controllers: { registrations: 'admins/registrations', sessions: 'admins/sessions' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'profiles#show'
end
