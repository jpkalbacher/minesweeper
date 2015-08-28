class Game
attr_reader :board
  def initialize(size = 9, bombs = size**2/4)
    @board = Board.new
  end

  def get_pos
    puts "Choose Move"
    move = gets.chomp.split("").map { |el| el.to_i }
  end

  def single_move
    move = get_pos

    return "Game Over" if board.is_bomb?(move)

    bomb_count = board.find_neighbor_bombs(move)
    if bomb_count > 0
      board[move].reveal = bomb_count
    else
      nil
    end
  end
end
