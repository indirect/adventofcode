#!/usr/bin/ruby

ids = File.read("input.txt").split("\n")
#ids = %w[
#  abcdef
#  bababc
#  abbcde
#  abcccd
#  aabcdd
#  abcdee
#  ababab
#]

twos = 0
threes = 0

ids.each do |id| 
  groups = id.chars.group_by{|c| c }
  twos += 1 if groups.find{|c, n| n.size == 2 }
  threes += 1 if groups.find{|c, n| n.size == 3 }
end

puts twos * threes
