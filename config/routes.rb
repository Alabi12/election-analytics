Rails.application.routes.draw do
  root 'home#index'

  resources :constituencies do
    resources :candidates
  end
end
