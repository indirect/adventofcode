#!/usr/bin/env ruby

class Wires
  def initialize(wire_list)
    @wires = wire_list.split("\n").map{|w| w.split(",") }
    @grid = {}
    @grid[[0,0]] = "o"

    @wire_dist = {}

    @wires.each.with_index do |steps, wire|
      @cursor = [0,0]
      wire_length = 0

      steps.each do |step|
        dir = step[0]
        dist = step[1..-1].to_i

        set("+")

        dist.times do |i|
          move(dir)
          wire_length += 1
          track_dist(wire, wire_length)
          %w[U D].include?(dir) ? set("|") : set("-")
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

  def track_dist(wire, distance)
    @wire_dist[wire] ||= {}
    @wire_dist[wire][[@cursor[0], @cursor[1]]] ||= distance
  end

  def lowest_distance
    @grid.select{|k,v| v == "X"}.map{|(x,y), _| x.abs + y.abs }.min
  end

  def best_steps
    @grid.select{|k,v| v == "X" }.keys.map do |loc|
      distances = @wire_dist.map{|i,w| w[loc] }
      distances.compact.size > 1 ? distances.sum : nil
    end.compact.tap{|steps| p steps }.min
  end

  def inspect
    return ""
    top = @grid.keys.map(&:last).min - 1
    left = @grid.keys.map(&:first).min - 1
    right = @grid.keys.map(&:first).max + 1
    bottom = @grid.keys.map(&:last).max + 1

    (top..bottom).map do |y|
      (left..right).map do |x|
        @grid[[x,y]] || "."
      end.join
    end.join("\n")

    # (top..bottom).map do |y|
    #   (left..right).map do |x|
    #     wire = @wire_dist.find{|i,wire| wire.has_key?([x,y]) }
    #     wire ? wire.last[[x,y]] : "."
    #   end.join
    # end.join("\n")
  end
end

p Wires.new("R8,U5,L5,D3\nU7,R6,D4,L4").tap{|w| puts w.inspect }.best_steps

p Wires.new("R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83").tap{|w| puts w.inspect }.best_steps

p Wires.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7").tap{|w| puts w.inspect }.best_steps

input = File.read("input.txt")
p Wires.new(input).best_steps
