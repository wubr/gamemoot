# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games do
    get 'new', action: :new
    post 'new', action: :create
  end

  resources :game_tables, only: [:create]

  resources :tables do
    get 'new', action: :new
    post 'new', action: :create
  end

  root to: 'tables#index'
end
