input = File.read("input.txt")

valid = input.lines.select do |line|
  range, letter, value = line.split(" ")
  letter.chomp!(":")
  min, max = range.split("-").map(&:to_i)
  count = value.count(letter)

  min <= count && count <= max
end

p valid.count
