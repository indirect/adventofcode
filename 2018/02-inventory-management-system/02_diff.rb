#!/usr/bin/ruby


ids = File.read("input.txt").split("\n")

#ids = %w[
#  abcde
#  fghij
#  klmno
#  pqrst
#  fguij
#  axcye
#  wvxyz
#]

matches = []

ids.permutation(2) do |id1, id2|
  if id1.chars.zip(id2.chars).select{|c1, c2| c1 != c2 }.size == 1
    matches << id1 << id2
    break
  end
end

m1, m2 = matches.map{|m| m.chars.to_a }
puts m1.zip(m2).select{|c1,c2| c1 == c2 }.map(&:first).join