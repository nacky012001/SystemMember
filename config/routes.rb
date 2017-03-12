Rails.application.routes.draw do
  root 'dashboard#index'
  resources :members 
  resources :charts

  get "import_members", :to => "members#import", :as => :import_members
  post "upload_members", :to => "members#upload", :as => :upload_members
  post "preview_members", :to => "members#preview", :as => :preview_members
end
