Rails.application.routes.draw do

  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  root 'welcome#index'
  resources :users do
    member do
      get :blogs
      get :download_pdf
      get :download_exist_pdf
    end
  end

  resources :sessions
  resources :blogs
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  namespace :admin do
    root to:'users#index'
    resources :users do
      collection do
        get :search
      end
    end
  end

  controller :welcome do
    get 'welcome/index'
    post 'welcome/create'
  end

  # resources :users, module: 'admin'
  # resources :users, only:[ :index ,:destroy]
  # 匹配：:get,:post的请求，都会匹配到该路由上
  # match 'photos',to: 'photos#show',via:[:get,:post]
  # #路由约束：photos/A12345 以A~Z之间的字母开头，结尾是5
  # get 'photos/:id',to: 'photos#show',constraints:{id:/[A~Z]\d{5}/}
  # #重定向到新的路由
  # get'stories',to:redirect('articles')

  # mount AdminApp, at:'/admin'
  # get 'profile' => 'users/show'

  # namespace :admin  do
  #   resources :users
  # end
  #
  # resources :users do
  #   member do
  #     post :status
  #   end
  #   collection do
  #     get :online
  #   end
  # end
  #
  # resources :users do
  #   post :status, on::member
  #   get :online, on::collection
  # end

end
