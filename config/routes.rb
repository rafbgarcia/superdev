Rails.application.routes.draw do
  root to: 'courses#index'

# Devise
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                    controllers: {
                      omniauth_callbacks: "users/omniauth_callbacks",
                      sessions: "users/sessions",
                    }

# Site
  get 'minha-historia' => 'application#my_history', as: :my_history
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
  post 'nova-inscricao' => 'subscriptions#create', as: :create_subscription

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

  resources :items, only: [] do
    resources :answers, only: [:create]
    patch :mark_as_done
  end

  resources :users, only: [:update] do
    collection do
      get :edit_password
      patch :update_password

      get :profile
      patch :update_profile

      get :dashboard
      get :subscription
    end
  end

  get 'notifications/:id/redirect' => 'notifications#redirect', as: :notification_redirect

  resources :comments, only: [:edit, :update]

  resources :blog_posts, path: '/dev_questions', only: [:index, :new, :create, :show] do
    post :comments
  end
  # get '/blog_posts(/:id)' => 'blog_posts#index', as: :blog_post # precisa ficar depois

################
# Admin Routes #
################

  get 'admin' => 'admin#index'

  namespace :admin do
    resources :projects

    resources :courses do
      resources :lessons do
        patch :update_weight

        resources :items do
          patch :update_weight
        end
      end
    end

    resources :blog_posts do
      patch :approve
    end
  end

end
