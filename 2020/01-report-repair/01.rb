input = File.read("input.txt")

input.lines.map(&:to_i).combination(2){|a,b| puts a*b if a+b == 2020 }
