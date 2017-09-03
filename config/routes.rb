# frozen_string_literal: true

Rails.application.routes.draw do
  resources :games do
    get 'new', action: :new
    post 'new', action: :create
  end
end
