Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/api/war/start_game', to: 'api#start_game'
  get  '/api/war/get_wins', to: 'api#get_wins'
end
