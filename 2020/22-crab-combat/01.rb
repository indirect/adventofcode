def play_round(players)
  p1c = players["Player 1:"].shift
  p2c = players["Player 2:"].shift

  if p1c > p2c
    players["Player 1:"].push(p1c, p2c)
  else
    players["Player 2:"].push(p2c, p1c)
  end
end

def part1(input)
  players = input.split("\n\n").map do |ps|
    list = ps.split("\n")
    [list[0], list[1..-1].map(&:to_i)]
  end.to_h

  round = 0
  until players.values.any?(&:empty?)
    round += 1
    play_round(players)
  end

  [round, players.map do |n, cards|
    [n, cards.reverse.map.with_index{|v, i| v*(i+1) }.sum]
  end.to_h]
end

# p part1(File.read("sample.txt"))
p part1(File.read("input.txt"))
