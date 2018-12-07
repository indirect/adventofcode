#!/usr/bin/ruby

#input = "1, 1\n1, 6\n8, 3\n3, 4\n5, 5\n8, 9".split("\n")
input = File.read("input.txt").split("\n")
coords = input.map{|i| i.split(", ").map(&:to_i) }

size = coords.flatten.max
grid = Array.new(size) { Array.new(size, nil) }

(0...grid.size).each do |col|
  (0...grid.first.size).each do |row|
    dists = coords.map.with_index do |(x, y), i|
      [(col - x).abs + (row - y).abs, i]
    end.sort_by(&:first)
    
    if dists[0][0] == dists[1][0]
      grid[col][row] = "."
    else
      grid[col][row] = dists[0][1]
    end  
  end
end

joined = grid.flatten(2)
sizes = (0...coords.size).map{|l| [l, joined.count(l)] }.reject{|l| l[1].zero? }.sort_by(&:last).to_h

(0...grid.size).each do |col|
  sizes.delete(grid[col][0])
  sizes.delete(grid[0][col])
  sizes.delete(grid[grid.size-1][col])
  sizes.delete(grid[col][grid.size-1])
end

p biggest = sizes.to_a.last
p coords[biggest.first]

#coords.each.with_index do |(x, y), i|
#  grid[x][y] = letter[i]
#end
#
#puts grid.map{|col| col.join("") }.join("\n")
