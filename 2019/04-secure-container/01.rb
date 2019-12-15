input = "236491-713787"
low, high = input.split("-").map(&:to_i)  # => [236491, 713787]

(low..high).select do |num|
  s = num.to_s
  s.squeeze.length < s.length && s.chars == s.chars.sort
end.size  # => 1169
