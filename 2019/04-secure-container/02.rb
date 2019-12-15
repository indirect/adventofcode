input = "236491-713787"
low, high = input.split("-").map(&:to_i)  # => [236491, 713787]

(low..high).select do |num|
  s = num.to_s
  s.chars == s.chars.sort && (0..9).find{|n| s.chars.count(n.to_s) == 2 }
end.size  # => 757
