Rails.application.routes.draw do
  
  get 'users/show'


  resources :admins, only: [:index]
  devise_for :admins, controllers: { registrations: 'admins/registrations', sessions: 'admins/sessions' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'profile#show'
end
