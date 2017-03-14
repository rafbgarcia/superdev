Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }


  get 'inscreva-se' => 'subscriptions#new', as: :subscribe
  post 'inscreva-se' => 'subscriptions#create'

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
    end



    resources :item, only: [] do
      resources :answers, only: [:create]
    end

    get 'notifications/:id/redirect' => 'notifications#redirect', as: :notification_redirect

  ################
  # Admin Routes #
  ################

    get 'admin' => 'admin#index'

    namespace :admin do
      resources :courses
      resources :lessons
      resources :items
    end

end
