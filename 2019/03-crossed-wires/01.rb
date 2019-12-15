#!/usr/bin/env ruby

class Wires
  def initialize(wire_list)
    @wires = wire_list.split("\n").map{|w| w.split(",") }
    @grid = {}
    @grid[[0,0]] = "o"

    @wires.each do |steps|
      @cursor = [0,0]

      steps.each do |step|
        dir = step[0]
        dist = step[1..-1].to_i

        case dir
        when "U", "D"
          set("+")
          dist.times { move(dir); set("|") }
        when "L", "R"
          set("+")
          dist.times { move(dir); set("-") }
        end
      end
    end
  end

  def get
    @grid[[@cursor[0], @cursor[1]]]
  end

  def set(char)
    return if @cursor == [0,0]

    if (get == "-" && char == "|") || (get == "|" && char == "-")
      @grid[[@cursor[0], @cursor[1]]] = "X"
    else
      @grid[[@cursor[0], @cursor[1]]] = char
    end
  end

  def move(dir)
    case dir
    when "L"
      @cursor[0] -= 1
    when "R"
      @cursor[0] += 1
    when "U"
      @cursor[1] -= 1
    when "D"
      @cursor[1] += 1
    end
  end

  def distance
    @grid.select{|k,v| v == "X"}.tap{|g| p g }.map{|(x,y), _| x.abs + y.abs }.min
  end

  def inspect
    top = @grid.keys.map(&:last).min - 1
    left = @grid.keys.map(&:first).min - 1
    right = @grid.keys.map(&:first).max + 1
    bottom = @grid.keys.map(&:last).max + 1

    (top..bottom).map do |y|
      (left..right).map do |x|
        @grid[[x,y]] || "."
      end.join
    end.join("\n")
  end
end

Wires.new("R8,U5,L5,D3\nU7,R6,D4,L4").tap{|w| p w.distance }

Wires.new("R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83").tap{|w| p w.distance }

p Wires.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7").distance

input = File.read("input.txt")
p Wires.new(input).distance
