require 'colorize'
require_relative 'piece.rb'

class Board
  
  attr_accessor :grid
  
  CURSOR = "|   |".blink
  
  def initialize(load = true)
    @grid = Array.new(8) { Array.new(8) }
    @board = self
    @cursor = [0,0]
    load_board if load
  end
  
  def load_board   
    @grid.reverse_each.with_index do |row, y_axis|
      row.each_with_index do |piece, x_axis|
        # Loads red pieces
        if (y_axis == 0 || y_axis == 2) && x_axis.even?
          grid[y_axis][x_axis] = Piece.new(:red , @board, [y_axis, x_axis])
        elsif y_axis == 1 && x_axis.odd?
          grid[y_axis][x_axis] = Piece.new(:red , @board, [y_axis, x_axis])
        end
        ## Loads white pieces
        if (y_axis == 5 || y_axis == 7) && x_axis.odd?
          grid[y_axis][x_axis] = Piece.new(:white , @board, [y_axis, x_axis])
        elsif y_axis == 6 && x_axis.even?
          grid[y_axis][x_axis] = Piece.new(:white , @board, [y_axis, x_axis])
        end
        
      end
    end
  end
   
  def render
    @grid.reverse_each.with_index do |row, y_axis|
      print "\n"
      print "#{(y_axis - 7).abs} ".light_white
      row.each_with_index do |piece, x_axis|
        colorize(piece, x_axis, y_axis)
      end
    end
    
    print "\n"
    print "    0   1   2   3   4   5   6   7  ".light_white
    print "\n"
  end
    
  def colorize(piece, x_axis, y_axis)
    if([x_axis, y_axis] == @cursor)
            print CURSOR
    else
      if (y_axis.even? && x_axis.even?) || (y_axis.odd? && x_axis.odd?)
        print "    ".on_red
      else
        if piece.nil?
          print "    ".on_black
        elsif piece.color == :red
          print "#{piece.char} ".light_red.on_black
        else
          print "#{piece.char} ".white.on_black
        end    
      end 
    end   
  end
  
  def move_cursor(dir)
    case dir
    when :up
      @cursor[1] -= 1 unless @cursor[1] == 0
    when :down
      @cursor[1] += 1 unless @cursor[1] == 7
    when :left
      @cursor[0] -= 1 unless @cursor[0] == 0
    when :right
      @cursor[0] += 1 unless @cursor[0] == 7
    end
  end
  
  def dup_board
    board = self.grid
    dup_board = Board.new(false)
    
    board.each_with_index do | row, y_idx |
      row.each_with_index do | column, x_idx |
        unless board[y_idx][x_idx].nil?
          dup_board.grid[y_idx][x_idx] = Piece.new(board[y_idx][x_idx].color, dup_board, [y_idx, x_idx])
        end
      end
    end
    
    dup_board
  end
  
  def won?(color)
    self.grid.flatten.compact.all? { |piece| piece.color == :color } 
  end
  
  def move_cursor(dir)
     case dir
     when :up
       @cursor[1] -= 1 unless @cursor[1] == 0
     when :down
       @cursor[1] += 1 unless @cursor[1] == 7
     when :left
       @cursor[0] -= 1 unless @cursor[0] == 0
     when :right
       @cursor[0] += 1 unless @cursor[0] == 7
     end
   end
  
end








