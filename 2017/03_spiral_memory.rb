#!/usr/bin/ruby

input = 325489

Grid = Struct.new(:size, :state) do
  def max
    size / 2
  end
end

Location = Struct.new(:x, :y) do
  def distance
    x.abs + y.abs
  end
end

def distance(input)
  input -= 1
  grid = Grid.new(3, 1)
  loc = Location.new(0, 0)

  while input > 0
    input -= 1
    case grid.state
    when 0
      loc.x += 1
      grid.state += 1 if loc.x == grid.max
    when 1
      loc.y += 1
      grid.state += 1 if loc.y == grid.max
    when 2
      loc.x -= 1
      grid.state += 1 if loc.x == -grid.max
    when 3
      loc.y -= 1
      grid.state += 1 if loc.y == -grid.max
    when 4
      loc.x += 1
      grid.state += 1 if loc.x == grid.max
    when 5
      loc.y += 1
      if loc.y.zero?
        grid.size += 2
        grid.state = 1
      end
    else
      p [grid, loc]
      raise "wtf"
    end
  end

  [loc.distance, grid, loc]
end

p distance 1
p distance 12
p distance 23
p distance 1024
p distance input

def sum(count)
  

p sum 1
p sum 2
p sum 5
p sum 10 # 26
p sum 23 # 806