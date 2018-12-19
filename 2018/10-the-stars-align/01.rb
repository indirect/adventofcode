#!/usr/bin/ruby

#input = DATA.read
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

__END__
position=< 9,  1> velocity=< 0,  2>
position=< 7,  0> velocity=<-1,  0>
position=< 3, -2> velocity=<-1,  1>
position=< 6, 10> velocity=<-2, -1>
position=< 2, -4> velocity=< 2,  2>
position=<-6, 10> velocity=< 2, -2>
position=< 1,  8> velocity=< 1, -1>
position=< 1,  7> velocity=< 1,  0>
position=<-3, 11> velocity=< 1, -2>
position=< 7,  6> velocity=<-1, -1>
position=<-2,  3> velocity=< 1,  0>
position=<-4,  3> velocity=< 2,  0>
position=<10, -3> velocity=<-1,  1>
position=< 5, 11> velocity=< 1, -2>
position=< 4,  7> velocity=< 0, -1>
position=< 8, -2> velocity=< 0,  1>
position=<15,  0> velocity=<-2,  0>
position=< 1,  6> velocity=< 1,  0>
position=< 8,  9> velocity=< 0, -1>
position=< 3,  3> velocity=<-1,  1>
position=< 0,  5> velocity=< 0, -1>
position=<-2,  2> velocity=< 2,  0>
position=< 5, -2> velocity=< 1,  2>
position=< 1,  4> velocity=< 2,  1>
position=<-2,  7> velocity=< 2, -2>
position=< 3,  6> velocity=<-1, -1>
position=< 5,  0> velocity=< 1,  0>
position=<-6,  0> velocity=< 2,  0>
position=< 5,  9> velocity=< 1, -2>
position=<14,  7> velocity=<-2,  0>
position=<-3,  6> velocity=< 2, -1>