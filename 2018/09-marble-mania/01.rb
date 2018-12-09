#!/usr/bin/ruby

def show(marbles, pos)
  marbles.map.with_index{|v, i| i == pos ? "(#{v})" : " #{v} " }.join
end

def score(input)
  input = input.split(" ")

  marbles = [0]
  players = Array.new(input[0].to_i, 0)
  last_value = input[-2].to_i
  high_score = 0
  
  value = 1
  pos = 0

  until value > last_value
    pi = value % players.size
    
    if (value % 23).zero?
      players[pi] += value
      pos = ((pos - 7) % marbles.size)
      players[pi] += marbles.delete_at(pos)
    else
      pos = ((pos + 1) % marbles.size) + 1
      marbles.insert(pos, value)
    end

#    puts "[#{pi}] " + show(marbles, pos)

    value += 1
  end

  players.max
end

tests = [
  "9 players; last marble is worth 25 points: high score is 32",
  "10 players; last marble is worth 1618 points: high score is 8317",
  "13 players; last marble is worth 7999 points: high score is 146373",
  "17 players; last marble is worth 1104 points: high score is 2764",
  "21 players; last marble is worth 6111 points: high score is 54718",
  "30 players; last marble is worth 5807 points: high score is 37305"
]

tests.each do |t|
  line, rest = t.split(": ")
  high_score = rest.split(" ")[-1].to_i
  
  p [score(line), high_score]
end

puts score(File.read("input.txt"))