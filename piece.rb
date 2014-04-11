require 'debugger'
class InvalidMoveError < RuntimeError 

end

class Piece
  attr_accessor :color, :board, :position, :char
  
  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
    @char = " \u2B24 "
  end
  
  
  def perform_slide(new_position)
    new_y, new_x = new_position
    
    move_diffs(new_position) if self.board.grid[new_y][new_x].nil?   
  end
  
  def move_diffs(new_position)
    y, x = @position
    new_y, new_x = new_position
    board = self.board.grid
    mod =  self.color == :white ?  1 : -1
    
    if (x - new_x).abs  == 1 && (y - new_y)  == mod
      @position = [new_y, new_x]
      board[new_y][new_x], board[y][x] = self, nil
      return true 
    end
    
    false 
  end
  
  def perform_jump(new_position)
    y, x = @position
    new_y, new_x = new_position
    enemy_y, enemy_x = ((y + new_y) / 2), ((x + new_x) / 2)
    board = self.board.grid
    self.color == :white ? (mod = 2) : (mod = -2)
    
    if board[enemy_y][enemy_x].nil?
      return false
    elsif (x - new_x).abs  == 2 && (y - new_y)  == mod && 
      board[enemy_y][enemy_x].color != self.color && board[new_y][new_x].nil?
      
     board[enemy_y][enemy_x], board[y][x], board[new_y][new_x] = nil, nil, self
     @position = [new_y, new_x]
     return true
    end
    
    false
  end
  
  def valid_move_seq?(sequence_of_moves)

    y,x = @position
    dup_board = self.board.dup_board
    dup_piece = dup_board.grid[y][x]
    
    if sequence_of_moves.count == 1
      return false unless dup_board.grid[y][x].perform_slide(sequence_of_moves[0]) ||
      dup_board.grid[y][x].perform_jump(sequence_of_moves[0])
    else
      sequence_of_moves.each do |new_move|
        return false unless dup_piece.perform_jump(new_move)
      end
    end
    true
  end
  
  
  def perform_moves!(sequence_of_moves)
    y,x = @position
    
    if sequence_of_moves.count == 1
      perform_slide(sequence_of_moves[0])
      perform_jump(sequence_of_moves[0])
    else
      sequence_of_moves.each { |new_move| perform_jump(new_move) }
    end      
  end
  
  def perform_moves(sequence_of_moves)
    begin
      if valid_move_seq?(sequence_of_moves)
        perform_moves!(sequence_of_moves)
      end
    rescue InvalidMoveError
      puts "Invalid Move"
      retry
    end
  end
  
  
          
end
