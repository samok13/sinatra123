require 'sinatra'
require_relative 'lib/tower_of_hanoi'

enable :sessions

get '/' do

  game = TowerOfHanoi.new

  session[:game] = game.towers

  erb :game, :locals => {:towers => game.towers, :error_message => nil, :winning_message => nil}

end


post '/' do

  game = TowerOfHanoi.new(session[:game])

  from = Integer(params[:from])
  to = Integer(params[:to])

  error_message = nil

  if game.valid_move?(from, to)
    game.move(from, to)
  else
    error_message = 'Invalid move'
  end

  winning_message = nil

  if game.win?
    winning_message = 'You win'
  end

  session[:game] = game.towers

  erb :game, :locals => {:towers => game.towers, :error_message => error_message, :winning_message => winning_message}

end



