def trees(filename)
  grid = File.read(filename+".txt").split("\n")

  tree_count = 0
  x, y = 0, 0
  until x > grid.size
    x += 1
    y += 3
    y = y % grid.first.length
    tree_count += 1 if grid[x] && grid[x][y] == "#"
  end

  tree_count
end

p trees("sample")

p trees("input")
