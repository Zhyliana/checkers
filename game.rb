require_relative 'board.rb'

class Game
  attr_reader :board, :current_player, :players
  
  def initialize
    @board = Board.new
    # @players = { :red => HumanPlayer.new(:red), :white => HumanPlayer.new(:white) }
    @current_player = :white
  end
  
  def play
    until board.won?(@current_player)
       begin
         get_moves
       rescue InvalidMoveError
         puts "Invalid Move" 
         retry
       end

       @current_player = (current_player == :white) ? :red : :white
     end
     
    @board.render
    puts "#{current_player} loses"
  end
  
  # def play 
  #   until board.won?(@current_player)
  #     board.render
  #     
  #     begin
  #       get_moves
  #     rescue => error
  #       puts "Invalid Move"
  #       retry
  #     end
  #     # players[current_player].play_turn(board) 
  #     @current_player = (current_player == :white) ? :red : :white
  #   end
  #   
  #   @board.render
  #   puts "#{current_player} loses"
  # end 
  
  def get_moves
    puts "#{@current_player}".capitalize + " make your move"
    puts "What piece would you like to move?"
    puts "Ex: 5,1"
    current_position = gets.chomp.split(",").map(&:to_i)

    puts "Enter the sequence of moves you'd like to perform"
    puts "Ex. 4,0 3,1"
    moves = gets.chomp.split(" ").map { |move|  move.split(",").map(&:to_i) }
    
    
    cur_y, cur_x = current_position[0], current_position[1]
    moves
 
    # @board.grid[cur_y][cur_x].perform_moves(moves)
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
    
    from_pos = get_pos("What piece would you like to move? ex. y, x")
    to_pos = get_pos("Where would you like to move this piece? y, x")
    to_x, to_y = from_pos
    from_x, from_y = from_pos
    
    board.grid[from_y.to_i][from_y.to_i].perform_moves([to_x.to_i, to_y.to_i])
  end
  
  def get_pos(prompt)
    puts prompt
    gets.chomp.split(", ").map(&:to_i)
  end
  
  def get_move_sequence
    positions = []
    
    positions << get_pos
    
    loop do 
      next_pos = get_pos
      
      return positions if next_pos.empty?
      position << next_pos
    end
  end
  
end
b= Board.new
# p Game.new.get_moves

p Game.new.board.grid[5][1].perform_moves([[4, 0]])
b.render
