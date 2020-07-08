Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount HealthMonitor::Engine, at: '/health/'

  scope '/help_center' do
    get 'terms_service', to: 'pages#terms_service', as: 'terms_service'
    get 'privacy_policy', to: 'pages#privacy_policy', as: 'privacy_policy'
    get 'markdown_rules', to: 'pages#markdown_rules', as: 'markdown_rules'
  end

  resources :users, path: '/', only: :show do
    member do
      get :follow
      get :unfollow
      get :block
      get :unblock
      get :followers
      get :followings
      get :chat, to: 'chatrooms#index', as: 'chat'
    end
  end

  scope '/users' do
    resources :web_notifications, only: :index do
      put :seen, on: :member
      put :mark_seen_all, on: :collection
    end
  end

  get 'explorer/posts', to: 'pages#explorer', as: 'explorer'
  resources :posts, path: '/p', except: :index do
    member do
      put :like
      get :users_liked
    end

    resources :comments, only: %i[index create destroy] do
      member do
        put :like
        get :users_liked
      end
    end
  end

  resources :messages, only: %i[create destroy]
end
