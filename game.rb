require 'byebug'
require_relative 'board'

class Game
  attr_reader :board

  def initialize(size = 9, bombs = 0)
    @board = Board.new(size, bombs)
  end

  def get_pos
    puts "Choose Move"
    move = gets.chomp.split("").map { |el| el.to_i }

    unless board.pos_on_board?(move)
      get_pos
    end
    move
  end

  def single_move
    move = get_pos

    Kernel.abort("Game Over") if board.is_bomb?(move)

    bomb_count = board.find_bomb_count(move)
    if bomb_count > 0
      board[move].reveal = bomb_count
    else
      computer_check(move)
      #board[move].reveal = "_"
    end
  end

  def computer_check(pos)
    board[pos].reveal = "_"

    (-1..1).each do |x_offset|
      (-1..1).each do |y_offset|
        x = x_offset + pos[0]
        y = y_offset + pos[1]
        bomb_count = board.find_bomb_count([x, y])
        if board.pos_on_board?([x, y]) && bomb_count > 0
          board[x, y].reveal = bomb_count
          return
        else
          return if board.pos_on_board?([x, y]) == false
          computer_check([x, y])
        end
      end
    end

  end

  def play
    while true
      system("clear")
      board.display
      single_move
    end
  end


end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
