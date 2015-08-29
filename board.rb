require 'colorize'
require_relative 'tile.rb'
require 'byebug'

class Board
  attr_reader :grid, :size, :bombs
  attr_accessor :possible_bombs


  def initialize(size, bombs)
    @grid = Array.new(size) { Array.new(size) }
    @size = size
    @bombs = bombs
    @possible_bombs = size**2
    populate
  end

  def check(pos)
    return if self[pos].reveal == "_" || self[pos].reveal != "*"
    self[pos].reveal = "_"


    (-1..1).each do |x_offset|
      (-1..1).each do |y_offset|
        neighbor_pos = [pos[0] + x_offset, pos[1] + y_offset]
        next if neighbor_pos == pos
        bomb_count = find_bomb_count(neighbor_pos)
        # x = x_offset + pos[0]
        # y = y_offset + pos[1]

        # debugger
        if !pos_on_board?(neighbor_pos) || self[neighbor_pos].bomb
          next
        elsif bomb_count > 0
          self[neighbor_pos].reveal = bomb_count
          # return
        else
          check(neighbor_pos)
          # return
        end
      end
    end
  end

  def display
    header = (0...size).to_a.join(" ")
    puts "#{@possible_bombs} LEFT"
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

  def possible_bomb_count
    # @possible_bombs
    counter = 0

    grid.each do |row|
      row.each do |tile|
        counter += 1 if tile.reveal = "_" || tile.reveal.is_a?(Fixnum)
      end
    end
    @possible_bombs = size**2 - counter
  end

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
