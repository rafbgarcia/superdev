Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }


  get 'inscreva-se/passo-1' => 'subscriptions#step_1', as: :subscribe_step_1
  get 'inscreva-se/passo-2' => 'subscriptions#step_2', as: :subscribe_step_2
  post 'inscreva-se/passo-2' => 'subscriptions#create_customer'
  get 'inscreva-se/passo-3' => 'subscriptions#new', as: :subscribe
  post 'inscreva-se/passo-3' => 'subscriptions#create'
  get 'aguardando-confirmacao' => 'subscriptions#waiting_confirmation'
  get 'inscricao-concluida' => 'subscriptions#complete', as: :subscribed

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
