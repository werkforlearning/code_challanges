Rails.application.routes.draw do
  root to: "main#index"
  
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

end
