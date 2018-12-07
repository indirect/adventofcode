#!/usr/bin/ruby

#input = "1, 1\n1, 6\n8, 3\n3, 4\n5, 5\n8, 9".split("\n")
#max_dist = 32

input = File.read("input.txt").split("\n")
max_dist = 10000

coords = input.map{|i| i.split(", ").map(&:to_i) }

size = coords.flatten.max
grid = Array.new(size) { Array.new(size, nil) }

(0...grid.size).each do |col|
  (0...grid.first.size).each do |row|
    dists = coords.map do |x, y|
      (col - x).abs + (row - y).abs
    end
    
    grid[col][row] = dists.sum
  end
end

p grid.flatten(2).count{|c| c < max_dist }
