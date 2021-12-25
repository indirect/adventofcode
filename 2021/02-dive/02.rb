def read(name)
  File.read(name).split("\n")
end

def move(name)
  depth, pos, aim = 0, 0, 0
  read(name).each do |i|
    a, x = i.split(" ")
    x = x.to_i
    case a
    when "forward"
      pos += x
      depth += (aim * x)
    when "down"
      aim += x
    when "up"
      aim -= x
    end
  end

  p [depth, pos]
  p depth * pos
end

move("sample.txt")
move("input.txt")
