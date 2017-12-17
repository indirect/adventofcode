
def next_generation(a, b)
  [
    (a * 16807) % 2147483647,
    (b * 48271) % 2147483647
  ]
end

def count_matches(a, b, rounds = 5)
  print "0%" if rounds > 1_000_000
  matches = 0

  rounds.times do |round|
    print "\r#{((round.to_f / rounds) * 100).round(2)}%" if rounds > 1_000_000 && (round % 200_000).zero?
    a, b = next_generation(a, b)
    lowest = [a, b].map{|n| n.to_s(2)[-16..-1] }
    matches += 1 if lowest[0] == lowest[1]
  end

  print "\r100%\n" if rounds > 1_000_000
  matches
end

puts "part 1"
raise "oh no" unless count_matches(65, 8921, 5) == 1
# p count_matches(65, 8921, 40_000_000) # 588
p count_matches(634, 301, 40_000_000)

def next_generation(a, b)
  a = (a * 16807) % 2147483647
  b = (b * 48271) % 2147483647
  a = (a * 16807) % 2147483647 until (a % 4).zero?
  b = (b * 48271) % 2147483647 until (b % 8).zero?
  [a, b]
end

puts "part 2"
raise "oh no" unless count_matches(65, 8921, 1056) == 1
p count_matches(634, 301, 5_000_000)
