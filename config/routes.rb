Rails.application.routes.draw do
  resources :articles
  root 'pages#home'
  get 'about', to: 'pages#about' #get request for about gives to pages#about controller
  get "signup", to: "users#new"
  resources :users, except:  [:new]
end
