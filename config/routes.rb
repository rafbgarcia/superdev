Rails.application.routes.draw do
  root to: 'courses#index'

# Devise
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

# Site
  get 'sobre' => 'application#about', as: :about
  get 'contato' => 'application#contact', as: :contact

# SSL Acme challenge
  get '.well-known/acme-challenge/:id' => 'application#acme_challenge'

# Amazon SES bounce notification
  post 'amazon_sns/bounce', 'amazon_sns#bounce'


# Iugu Notifications
  post 'iugu/invoice/status_changed' => 'iugu#status_changed'

# Subscription
  get 'pioneiros' => 'subscriptions#pioneiros', as: :pioneiros
  get 'partiu-codar' => 'subscriptions#partiu_codar', as: :subscribe_step_1
  post :create, controller: 'subscriptions', as: :create_subscription

  get 'aguardando-confirmacao' => 'subscriptions#waiting_confirmation'
  get 'inscricao-concluida' => 'subscriptions#complete', as: :subscribed

# Sales pages
  get 'como-programar-do-zero(/:video_id)' => 'sales_pages#index', as: :sales

##################
# Student Routes #
##################

  scope 'cursos/:course_id' do
    get '/' => 'courses#show', as: :course
    get '/:lesson_id/:item_weight' => 'items#show', as: :course_item

    scope '/:lesson_id/:item_weight/post/:discussion_id' do
      get '/' => 'items#show', as: :discussion
      post '/comments' => 'items#create_comment', as: :create_comment
    end
  end

  scope 'questao/:item_id' do
    get 'novo-post' => 'discussions#new', as: :new_discussion
    post 'novo-post' => 'discussions#create', as: :discussions

    get '/:discussion_id/edit' => 'discussions#edit', as: :edit_discussion
    patch '/:discussion_id/edit' => 'discussions#update'
  end

  resources :item, only: [] do
    resources :answers, only: [:create]
  end

  resources :users, only: [:update] do
    collection do
      get :edit_password
      patch :update_password

      get :profile
      patch :update_profile

      get :dashboard
    end
  end

  get 'notifications/:id/redirect' => 'notifications#redirect', as: :notification_redirect

  resources :comments, only: [:edit, :update]

  resources :blog_posts, only: [:new, :create] do
    post :comments
  end
  get '/blog_posts(/:id)' => 'blog_posts#index', as: :blog_post # precisa ficar depois

################
# Admin Routes #
################

  get 'admin' => 'admin#index'

  namespace :admin do
    resources :courses
    resources :blog_posts do
      patch :approve
    end
    resources :lessons do
      patch :update_weight
    end

    resources :items do
      patch :update_weight
    end
  end

end
