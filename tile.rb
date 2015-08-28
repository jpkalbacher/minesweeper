class Tile
  attr_reader :bomb, :reveal

  def initialize(bomb = false)
    @bomb = bomb
    @reveal = "*" #Options are "*","F",count,_

  end

end
