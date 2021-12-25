def read(name)
  File.read(name).split("\n")
end

def move(name)
  depth, pos = 0, 0
  read(name).each do |i|
    a, b = i.split(" ")
    b = b.to_i
    case a
    when "forward"
      pos += b
    when "down"
      depth += b
    when "up"
      depth -= b
    end
  end

  p [depth, pos]
  p depth * pos
end

move("sample.txt")
move("input.txt")
