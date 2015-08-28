require 'colorize'
require_relative 'tile.rb'
require 'byebug'

class Board
  attr_reader :grid, :size, :bombs

  def initialize(size, bombs)
    @grid = Array.new(size) { Array.new(size) }
    @size = size
    @bombs = bombs
    populate
  end

  def display
    header = (0...size).to_a.join(" ")
    puts "  #{header}".colorize(:blue)
    self.grid.each_with_index do |row, i|
      display_row(row, i)
    end
    nil
  end

  def display_row(row, i)
    tiles = row.map { |tile, i| tile.reveal }.join(" ")
    puts "#{i.to_s.colorize(:blue)} #{tiles}"
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

  def is_bomb?(pos)
    self[pos].bomb
  end

  def find_bomb_count(pos)
    total_bombs = 0

    (-1..1).each do |x_offset|
      (-1..1).each do |y_offset|
        x = x_offset + pos[0]
        y = y_offset + pos[1]
        if pos_on_board?([x, y]) && self[[x, y]].bomb
         total_bombs += 1
        end
      end
    end

    total_bombs
  end


  # def find_bomb_locations(pos)
  #   bomb_placements = []
  #
  #   (-1..1).each do |x_offset|
  #     (-1..1).each do |y_offset|
  #       x = x_offset + pos[0]
  #       y = y_offset + pos[1]
  #       if pos_on_board?([x, y]) && self[[x, y]].bomb
  #        bomb_placements << [x,y]
  #       end
  #     end
  #   end
  #
  #   bomb_placements
  # end
  #
  # def find_touching_spaces(pos)
  #   (-1..1).each do |x_offset|
  #     (-1..1).each do |y_offset|
  #       x = x_offset + pos[0]
  #       y = y_offset + pos[1]
  #       if pos_on_board?([x, y]) && !used_spaces.include?[x,y]
  #

  def pos_on_board?(pos)
    pos.all? { |pos| (0...size).include?(pos) }
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
