OdcInduction::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  
  root 'home#homepage'

  get '/associate' => 'users/associates#associate_home'
  get '/change_pwd(/:token)' => 'users/associates#change_pwd', as: 'change_pwd'
  get '/admin' => 'users/admins#admin_home'
  get '/tag_mentor' => 'users/admins#tag_mentor'
  post '/tag_mentor' => 'users/admins#tag_mentor_update'
  post '/untag_mentor' => 'users/admins#untag_mentor'
  post '/edit_role' => 'users/admins#edit_role'
  post '/edit_tag' => 'users/admins#edit_tag'
  get '/new_user' => 'users/admins#new_user'
  post 'create_user' => 'users/admins#create_user'
  get '/change_role' => 'users/admins#change_role'

  #post '/create_update' => 'users/associates#create_update'
  #post '/create_comment' => 'comment#create_comment'
  get '/tasks/get_tasks'
  get '/tasks/get_updates'
  #get '/get_tasks' => 'tasks#get_tasks'

  post '/import_users' => 'users/admins#import_users'
  get '/mentees_updates' => 'users/admins#view_mentees_updates'
  get '/view_mentors' => 'users/admins#view_mentors'
  get '/view_associates' => 'users/admins#view_associates'
  post '/email_updates' => 'users/admins#email_updates'
  delete '/destroy_user' => 'users/admins#destroy_user'
  #delete '/destroy_comment' => 'users/associates#destroy_comment'

  get '/feedback(/:rating(/:token))' => 'feedbacks#feedback', as: 'get_feedback'
  get '/archives' => 'users/admins#archives', as: 'archives'


  resources :comments, only: [:destroy, :create]
  resources :updates, only: [:create]
  resources :tasks, only: [:create,:update]
  resources :feedbacks, only: [:update]
  resources :users, only: [:update], controller: 'users/associates' 
end