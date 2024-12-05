Rails.application.routes.draw do
  root 'home#index'

  resources :constituencies do
    resources :candidates
    resources :votes, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
