input = <<END
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
END
input = File.read("input.txt")

valid = input.lines.select do |line|
  range, letter, value = line.split(" ")
  letter.chomp!(":")
  l, r = range.split("-").map(&:to_i)

  e = (value[l-1] == letter) != (value[r-1] == letter)
  #p [line.chomp, value, value[l-1],value[r-1],letter, e]
end

p valid.count
