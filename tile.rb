class Tile
  attr_reader :bomb, :reveal

  def initialize(bomb = false)
    @bomb = bomb
    @reveal = "*"
  end

  def find_neighbor_bombs
    
  end
end
