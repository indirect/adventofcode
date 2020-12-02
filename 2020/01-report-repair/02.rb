input = File.read("input.txt")

input.lines.map(&:to_i).combination(3){|a,b,c| puts a*b*c if a+b+c == 2020 }
