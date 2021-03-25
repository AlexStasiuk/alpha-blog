Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about' #get request for about gives to pages#about controller
end
