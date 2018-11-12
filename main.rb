require './game'

puts "Let's play Tic Tac Toe!" 
puts "Player One, what is your name?" 
player_one = gets.chomp
puts "Player Two, what is your name?"
player_two = gets.chomp

game = Game.new(player_one, player_two)
game.start
