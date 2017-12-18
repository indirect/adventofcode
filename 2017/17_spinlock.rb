input = 356
test = 3

def spin(input, count = 2017)
  buffer = [0]
  pos = 0

  1.upto(count) do |i|
    pos += input
    pos = pos % buffer.size
    pos += 1
    buffer.insert(pos, i)
  end

  buffer[pos + 1]
end

puts "part 1"
raise "oh no" unless spin(test) == 638
puts spin(input)

def angry_spin(input, count = 50_000_000)
  size = 1
  pos = 0
  value = nil

  1.upto(count) do |i|
    pos += input
    pos = pos % size
    pos += 1
    value = i if pos == 1
    size += 1
  end

  value
end

puts "part 2"
raise "oh no" unless angry_spin(test, 2017) == 1226
puts angry_spin(input)
