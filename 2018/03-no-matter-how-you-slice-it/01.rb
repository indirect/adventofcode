#!/usr/bin/ruby

claims = File.read("input.txt").split("\n")
#claims = [
#  "#1 @ 1,3: 4x4",
#  "#2 @ 3,1: 4x4",
#  "#3 @ 5,5: 2x2"
#]

fabric = Array.new(1000) { Array.new(1000, 0) }

claims.each do |claim|
  loc, size = claim.split(" @ ").last.split(": ")
  loc = loc.split(",").map(&:to_i)
  size = size.split("x").map(&:to_i)
  (loc[0]...loc[0]+size[0]).each do |i|
    (loc[1]...loc[1]+size[1]).each do |j|
      fabric[i][j] += 1
    end
  end
end

puts fabric.map{|a| a.count{|e| e > 1 } }.inject(:+)