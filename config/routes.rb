# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :stocks
      resources :storehouses, only: [:index]

      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#delete'
      get '/logged_in', to: 'sessions#show'
    end
  end
end
