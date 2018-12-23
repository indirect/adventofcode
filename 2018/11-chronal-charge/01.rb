#!/usr/bin/ruby

input = 7165

class Grid
  def initialize(id, debug = false)
    @id = id
    @debug = debug
  end

  def power(x, y)
    rack_id = x + 10
    power = rack_id * y
    power += @id
    power *= rack_id
    power = (power % 1000) / 100
    power -= 5
    puts "[#{x},#{y}] #{power}" if @debug
    power
  end
  
  def square(x, y)
    (x...x+3).map do |xi|
      (y...y+3).map do |yi|
        power(xi, yi)
      end.sum
    end.sum
  end
  
  def largest_square
    squares = {}

    0.upto(299) do |x|
      0.upto(299) do |y|
        squares[[x,y]] = square(x, y)
      end
    end
    
    squares.to_a.max_by(&:last)
  end
end

#p Grid.new(8).power(3,5)
#p Grid.new(57).power(122,79)
#p Grid.new(39).power(217,196)
#p Grid.new(71).power(101,153)
#p Grid.new(18).largest_square
#p Grid.new(42).largest_square

p Grid.new(input).largest_square