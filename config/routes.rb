# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/mobster/classify', to: 'mobster#classify'
      get '/mobster/check', to: 'mobster#check'
    end
  end
end
