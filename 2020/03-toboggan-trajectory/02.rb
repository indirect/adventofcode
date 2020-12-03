def trees(filename, dx = 1, dy = 3)
  grid = File.read(filename+".txt").split("\n")

  tree_count = 0
  x, y = 0, 0
  until x > grid.size
    x += dx
    y += dy
    y = y % grid.first.length
    tree_count += 1 if grid[x] && grid[x][y] == "#"
  end

  tree_count
end

def check_slopes(filename)
  slopes = [
    [1,1],
    [3,1],
    [5,1],
    [7,1],
    [1,2],
  ]
  slopes.map { |(dy,dx)| trees(filename, dx, dy) }.inject(:*)
end

p check_slopes("sample")
p check_slopes("input")

