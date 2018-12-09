Rails.application.routes.draw do
    
  get '/search' => 'rooms#search'
  
  post '/report' => 'rooms#report_create'
  get '/report' => 'rooms#report'

  devise_for :users, :controllers => { registrations: 'users/registrations' }
  
  mount RailsAdmin::Engine => '/bomuck', as: 'rails_admin'
  
  root 'rooms#index'
  resources :rooms do 
    member do
     delete '/exit' => 'rooms#user_exit_room'
     post '/ready' => 'rooms#is_user_ready'
     post '/open_chat' => 'rooms#open_chat'
     post '/chat' => 'rooms#chat'
     get '/chat' => 'rooms#chat'
   end
 end

  get 'rooms/hashtags/:name' => 'rooms#hashtags'
  
  get '/quickmatch' => 'rooms#quickmatch'
  get '/matching'=>'rooms#matching'
    
end