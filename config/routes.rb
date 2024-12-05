Rails.application.routes.draw do
  resources :constituencies do
    resources :candidates
  end
end
