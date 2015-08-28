require './tile.rb'
require 'byebug'

class Board
  attr_reader :grid, :size, :bombs

  def initialize(size = 9, bombs = size**2/4)
    @grid = Array.new(size) { Array.new(size) }
    @size = size
    @bombs = bombs
  end

  def display
    header = (0...size).to_a.join(" ")
    p "  #{header}"
    self.grid.each_with_index do |row, i|
      display_row(row, i)
    end
  end

  def display_row(row, i)
    tiles = row.map { |tile, i| tile.reveal }.join(" ")
    p "#{i} #{tiles}"
  end

  def populate
    bombs.times { place_tile(Tile.new(true)) }
    (size**2-bombs).times { place_tile(Tile.new) }
  end

  def place_tile(tile)

    position = random_pos

    until self[position].nil?
      position = random_pos
    end

    self[position] = tile
  end

  def valid_position?(pos)
    [-1..1].each do |x|
      [-1..1].each do |y|

      end
    end
  end

  def random_pos
    result = []
    2.times { result << rand(size) }
    result
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    grid[x][y] = value
  end

  private
end
