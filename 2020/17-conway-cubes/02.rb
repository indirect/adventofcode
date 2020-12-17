def neighbors(x,y,z,w, cube)
  [w-1, w, w+1].map do |ww|
    [z-1, z, z+1].map do |zz|
      [x-1, x, x+1].map do |xx|
        [y-1, y, y+1].map do |yy|
          next if x == xx && y == yy && z == zz && w == ww
          cube[[xx,yy,zz,ww]]
        end
      end
    end
  end.flatten.compact.select{|v| v }
end

def step(cube)
  min_x = 0
  min_y = 0
  min_z = 0
  min_w = 0
  max_x = 0
  max_y = 0
  max_z = 0
  max_w = 0

  cube.keys.each do |x,y,z,w|
    min_x = x if x < min_x
    min_y = y if y < min_y
    min_z = z if z < min_z
    min_w = w if w < min_w
    max_x = x if x > max_x
    max_y = y if y > max_y
    max_z = z if z > max_z
    max_w = w if w > max_w
  end

  new_cube = Hash.new(false)

  (min_w-1..max_w+1).each do |w|
    (min_x-1..max_x+1).each do |x|
      (min_y-1..max_y+1).each do |y|
        (min_z-1..max_z+1).each do |z|
          count = neighbors(x,y,z,w, cube).count

          new_cube[[x,y,z,w]] = if cube[[x,y,z,w]]
                                  count == 2 || count == 3 ? true : false
                                else
                                  count == 3 ? true : false
                                end
        end
      end
    end
  end

  new_cube
end

def debug(cube)
  (0..0).each do |z|
    puts "z=#{z}"
    s = (0..3).map do |x|
      (0..3).map do |y|
        cube[[x,y,z]] ? "#" : "."
      end.join("")
    end.join("\n")
    puts s
  end
end

def part1(input)
  cube = Hash.new(false)

  input.each.with_index do |l, x|
    l.chars.each.with_index do |c, y|
      cube[[x,y,0,0]] = true if c == "#"
    end
  end

  # cube = step(cube)

  6.times do
    cube = step(cube)
  end

  cube.values.count(true)
end

# p part1(File.read("sample.txt").split)
p part1(File.read("input.txt").split)

