Rails.application.routes.draw do
  # USERS
  get    '/user/me'  => 'users#current'
  get    '/users'          => 'users#index'
  post   '/registration'   => 'users#create'
  patch  '/user/:id'       => 'users#update'
  delete '/user/:id'       => 'users#destroy'

  # LOGIN
  post   '/o/token'      => 'user_token#create'
  
  # EXAMS
  get '/exam/me' => 'exam#me'
  get '/exam/:id' => 'exam#show'
  
  # REPORTS
  resources :reports

  # CONTACT
  
  # NEWS
  get '/news/posts' => 'news#index'
end
