# frozen_string_literal: true

Rails.application.routes.draw do
  # You might think that using resource only for index is strange.
  # This looks familiar and it's clear that what i'm doing to
  resources :greeter, only: %i[index] do
    collection { get 'about' }
  end

  resource :sessions, only: %i[new create destroy]
  resources :users, except: %i[index] do
    member { post :update_role }
  end
  resources :posts
  resources :roles, except: %i[index show] do
    collection { post :search }
  end
  resources :grants, except: %i[index show] do
    collection { post :search }
  end
  resources :confirmations, only: %i[create edit new], param: :confirmation_token
  resources :passwords, except: %i[index destroy show], param: :password_reset_token
  resources :active_sessions, only: [:destroy] do
    collection { delete 'destroy_all' }
  end

  root to: 'greeter#index'
end
