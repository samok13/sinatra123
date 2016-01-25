require 'sinatra'
require_relative 'lib/tower_of_hanoi'
require 'json'

enable :sessions

get '/' do

@game = TowerOfHanoi.new

session[:game] = @game.towers.to_json

erb :game, :locals => {:towers => @game.towers}

end


post '/' do

@game = TowerOfHanoi.new(JSON.parse(session[:game]))

from = Integer(params[:from])
to = Integer(params[:to])

# @error_message = nil

if @game.valid_move?(from, to)
  @game.move(from, to)
# else
  # @error_message = 'Invalid move'
end

session[:game] = @game.towers.to_json

erb :game, :locals => {:towers => @game.towers}

end



