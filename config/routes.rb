Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount HealthMonitor::Engine, at: '/health/'

  resources :users, path: '/', only: :show do
    member do
      get :follow
      get :unfollow
      get :block
      get :unblock
      get :followers
      get :followings
    end
  end

  get 'explorer/posts', to: 'pages#explorer', as: 'explorer'
  resources :posts, path: '/p', except: :index
end
