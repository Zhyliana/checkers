require_relative 'board.rb'

class Game
  attr_reader :board, :current_player, :players
  
  def initialize
    @board = Board.new
    @players = { :red => HumanPlayer.new(:red), :white => HumanPlayer.new(:white) }
    @current_player = :white
  end
  
  def play 
    until board.won?(@current_player)
      players[current_player].play_turn(board) 
      @current_player = (current_player == :white) ? :red : :white
    end
    
    board.render
    puts "#{current_player} loses"
    
    nil
  end    
  
end

class HumanPlayer
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  def play_turn(board)
    board.render
    puts "#{color}".capitalize + " make your move"
    
    from_pos = get_pos("What piece would you like to move? ex. [y, x]")
    to_pos = get_pos("Where would you like to move this piece? [y, x]")
    
    from_x, from_y = from_pos
    board.grid[from_y][from_y].perform_moves(to_pos)
      
  end
  
  def get_pos(prompt)
    puts prompt
    pos = gets.chomp
    [pos]
  end
end

Game.new.play