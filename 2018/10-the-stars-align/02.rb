#!/usr/bin/ruby

input = File.read("test.txt")
input = File.read("input.txt")

points = input.lines.map do |line|
  line.match(/position=<(.+),(.+)> velocity=<(.+),(.+)>/).to_a[1..-1].map(&:to_i)
end

def height(points)
  ys = points.map{|p| p[1] }
  (ys.max - ys.min).abs
end

def show(points)
  xs = points.map(&:first)
  ys = points.map{|p| p[1] }

  grid = Array.new(ys.max + 1) { "." * (xs.max + 1) }

  points.each do |point|
    x = point[0]
    y = point[1]
    grid[y][x] = "#"
  end

  puts grid
end

def step(points)
  @step ||= 0
  @step += 1
  
  points.each do |point|
    point[0] += point[2]
    point[1] += point[3]
  end
  
  xoff = points.map{|n| n[0]}.min
  yoff = points.map{|n| n[1]}.min

  points.each do |point|
    point[0] -= xoff
    point[1] -= yoff
  end
end

step(points) until height(points) < 10
show(points)
p @step
