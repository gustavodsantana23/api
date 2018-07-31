Rails.application.routes.draw do
	resources :reports

    # Home controller routes.
  # root   'home#index'
  # get    'auth'            => 'home#auth'
  get '/news/posts' => 'news#index'
  get '/profile/:id' => 'profile#show'
  get '/exam/:id' => 'exam#show'
  
  # Get login token from Knock
  post   '/o/token'      => 'user_token#create'
  
  # User actions
  get    '/users'          => 'users#index'
  get    '/user/me'  => 'users#current'
  post   '/registration'   => 'users#create'
  patch  '/user/:id'       => 'users#update'
  delete '/user/:id'       => 'users#destroy'
end
