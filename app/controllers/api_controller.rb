class ApiController < ApplicationController
  
  def get_wins
    response = ::War::Handlers::GetWins.call
    render json: response
  end

  def start_game
    data = JSON.parse(request.body.read)
    response = ::War::Handlers::StartGame.call(data)
    render json: response
  end
end
