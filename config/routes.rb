# config/routes.rb

Rails.application.routes.draw do
  # Devise Authentication Routes
  devise_for :users
  
  # Root path
  root 'home#index'

  resources :votes, only: [:create]
  resources :candidates, only: [:index, :show]

  # Admin routes with user management access
  namespace :admin do
    get "analytics/index"
    resources :users
  end

  resources :constituencies do
    resources :candidates do
      patch 'add_vote', on: :member # Add a route to update vote_count
    end
  end
  
  # Routes for the dashboards
  get 'admin_dashboard', to: 'dashboards#admin_dashboard', as: 'admin_dashboard'
  get 'party_agent_dashboard', to: 'dashboards#party_agent_dashboard'

  resources :party_agents

  resources :votes, only: [:create]
  resources :candidates do
    resources :votes, except: [:create]
  end  
end
