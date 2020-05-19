Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount HealthMonitor::Engine, at: '/health/'

  get ':id', to: 'users#show', as: 'user'
  get 'explorer/posts', to: 'pages#explorer', as: 'explorer'
  resources :posts, except: :index
end
