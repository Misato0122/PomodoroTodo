Rails.application.routes.draw do
  root to: 'home#index'

  resources :users

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  resources :tasks, only: %i[index show create edit update destroy] do
    member do
      post '/pomodoros', to: 'pomodoro_timer#create'
      get '/timer', to: 'pomodoro_timer#timer'
    end
  end

end
