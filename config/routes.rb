Rails.application.routes.draw do
  root 'dashboard#index'
  resources :members 
  resources :charts
end
