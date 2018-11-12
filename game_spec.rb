require './game'

describe Game do
  before do
    allow($stdout).to receive(:write)
  end

  it 'can display a starting board' do 
    Game.new.display_board == ['1', '2', '3', '\n', '4', '5', '6', '\n', '7', '8', '9']
  end
  
  it 'allows players to make moves' do 
    allow($stdin).to receive(:gets).and_return('1')
    game = Game.new('Player One', 'Player Two')
    game.turn(game.first_player)
    game.board == ['X', '2', '3', '4', '5', '6', '7', '8', '9']
  end

  it 'checks to see if a win condition has been met' do 
    game = Game.new('Player One', 'Player Two')
    allow($stdin).to receive(:gets).and_return('1', '2', '3')
    3.times do 
      game.turn(game.first_player)
    end
    game.winner == game.first_player
  end
end
