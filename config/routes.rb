Rails.application.routes.draw do
  require 'sidekiq/web'
  devise_for :users
  root 'torrents#index'
  resources :torrents
  get 'torrents/:id/package', to: 'torrents#package'
  get 'torrents/:id/restore', to: 'torrents#restore'
  resources :users
  resources :blog
  get 'rules', to: 'static#rules'
  namespace :moderator do
    get '', to: 'dashboard#index', as: '/'
  end
  mount Peek::Railtie => '/peek'
  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web, at: '/admin/sidekiq'
  end
end
