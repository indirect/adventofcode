#!/usr/bin/ruby
Node = Struct.new(:value, :prev, :next)

def marbles_from(root, pos)
  s = " #{root.value} "
  node = root.next
  until node == root
    s << (node == pos ? "(#{node.value})" : " #{node.value} ")
    node = node.next
  end
  s
end

def score(input)
  input = input.split(" ")

  players = Array.new(input[0].to_i, 0)
  last_value = input[-2].to_i * 100
  high_score = 0
  
  value = 1
  root = Node.new(0, nil, nil)
  pos = root
  pos.next = pos
  pos.prev = pos

  until value > last_value
    pi = value % players.size
    
    if (value % 23).zero?
      players[pi] += value
      7.times { pos = pos.prev }
      players[pi] += pos.value
      
      # delete
      pos.next.prev = pos.prev
      pos.prev.next = pos.next
      pos = pos.next
    else
      pos = pos.next

      # insert
      pos = Node.new(value, pos, pos.next)
      pos.prev.next = pos.next.prev = pos
    end
    
    # puts marbles_from(root, pos)

    value += 1
  end

  players.max
end

tests = [
  "9 players; last marble is worth 25 points: high score is 32",
  "10 players; last marble is worth 1618 points: high score is 8317",
#  "13 players; last marble is worth 7999 points: high score is 146373",
#  "17 players; last marble is worth 1104 points: high score is 2764",
#  "21 players; last marble is worth 6111 points: high score is 54718",
#  "30 players; last marble is worth 5807 points: high score is 37305"
]

tests.each do |t|
  line, rest = t.split(": ")
  high_score = rest.split(" ")[-1].to_i
  
  p [score(line), high_score]
end

puts score(File.read("input.txt"))