class Game
  attr_accessor :first_player, :second_player, :board
  def initialize(first_player= nil, second_player= nil)
    @first_player = first_player
    @second_player = second_player
    @first_player_marker = 'X'
    @second_player_marker = 'O'
    @board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
  end
  
  def start
    while !game_over?
      display_board
      turn(@first_player)
      break if check_if_game_over
      display_board
      turn(@second_player)
      check_if_game_over
    end
  end

  def check_if_game_over
    return false unless game_over?
    if winner
      puts "#{winner} won!"
    else
      puts "It's a tie!"
    end
    true
  end

  def display_board
    puts @board.insert(0, "\n").insert(4, "\n").insert(8, "\n").join(' ')
    @board = @board.reject{ |x| x == "\n" }
  end
  
  def get_action
    $stdin.gets.chomp
  end

  def get_player_input(player)
    invalid_input = true
    while invalid_input
      puts "#{player}, enter your square"
      answer = $stdin.gets.chomp
      if available_spaces.include? answer
        invalid_input = false
      else
        puts "Your response is either invalid or the square is already taken. Please enter another response."
      end
    end
    answer
  end
  
  def available_spaces
    @board.reject{ |x| x == @first_player_marker || x == @second_player_marker }
  end

  def turn(player)
    player_input = get_player_input(player)
    mark = player == @first_player ? @first_player_marker : @second_player_marker
    @board = @board.map{ |x| x == player_input ? mark : x }
    puts @board
  end

  def starting_board
    ['1', '2', '3', '4', '5', '6', '7', '8', '9']
  end

  def board_has_no_empty_spaces?
    starting_board.each do |x|
      return false if @board.include? x
    end
    true
  end

  def game_over?
    return true if winner 
    return true if board_has_no_empty_spaces? 
    false
  end
  
  def check_if_player_won(player)
    marker = player == @first_player ? @first_player_marker : @second_player_marker
    player_positions = []
    @board.each_with_index{ |val, index| player_positions << index if val == marker }  
    winning_conditions.include?  player_positions
  end

  def winner
    return @first_player if check_if_player_won(@first_player)
    return @second_player if check_if_player_won(@second_player)
    false
  end
   
  private def winning_conditions
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end
end
