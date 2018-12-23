#!/usr/bin/ruby
require "matrix"

input = 7165

class Grid
  def initialize(id, debug = false)
    @id = id
    @debug = debug
    @cells = Matrix.build(300, 300){|x, y| power(x, y) }
  end

  def power(x, y)
    rack_id = x + 10
    power = rack_id * y
    power += @id
    power *= rack_id
    power = (power % 1000) / 100
    power -= 5
#    puts "[#{x},#{y}] #{power}" if @debug
    power
  end
  
  def square(x, y, size = 3)
    @cells.minor(x, size, y, size).inject(0, :+)
  end
  
  def largest_square
    squares = {}
    
    1.upto(300) do |size|
      squares[size] = (0...(300-size)).map do |x|
        (0...(300-size)).map do |y|
          [x, y, size, square(x, y, size)]
        end.max_by(&:last)
      end.max_by(&:last)

      p [size, squares[size]] if @debug

      break if squares[size].last < 0
    end
    
    squares.values.max_by(&:last)
  end
end

#p Grid.new(18).largest_square
p Grid.new(input, :debug).largest_square