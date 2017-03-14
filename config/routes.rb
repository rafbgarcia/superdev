Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }


  get 'inscreva-se' => 'subscriptions#new', as: :subscribe
  post 'inscreva-se' => 'subscriptions#create'

  ##################
  # Student Routes #
  ##################

    get 'curso/:id', to: 'courses#show', as: :course
    get 'curso/:course_id/licao/:lesson_id/item/:item_weight', to: 'items#show', as: :course_item

    scope 'curso/:course_id/licao/:lesson_id/item/:item_weight' do
      scope 'discussao' do
        get 'nova', to: 'discussions#new', as: :new_discussion
        post 'nova', to: 'discussions#create', as: :discussions

        get ':discussion_id', to: 'items#show', as: :discussion
        post ':discussion_id/comments', to: 'comments#create', as: :comments
      end

    end

    resources :item, only: [] do
      resources :answers, only: [:create]
    end

    get 'notifications/:id/redirect', to: 'notifications#redirect', as: :notification_redirect

  ################
  # Admin Routes #
  ################

    get 'admin', to: 'admin#index'

    namespace :admin do
      resources :courses
      resources :lessons
      resources :items
    end

end
