Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount HealthMonitor::Engine, at: '/health/'

  scope '/help_center' do
    get 'terms_&_conditions', to: 'pages#terms_conditions', as: 'terms_conditions'
    get 'privacy_policy', to: 'pages#privacy_policy', as: 'privacy_policy'
  end

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
  resources :posts, path: '/p', except: :index do
    member do
      put :like
      get :users_liked
    end
  end
end
