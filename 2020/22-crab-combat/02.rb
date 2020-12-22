require "set"

def log(*msg)
  # puts(*msg)
end

$game = 0
def play_game(p1cards, p2cards)
  game = $game += 1
  log "=== Game #{game} ===\n"

  history = Set.new
  round = 1

  until p1cards.empty? || p2cards.empty?
    card_state = [p1cards.dup, p2cards.dup]
    return 1 if history.include?(card_state)
    history.add(card_state)

    log "\n-- Round #{round} (Game #{game}) --"

    log "Player 1s deck: #{p1cards.join(", ")}"
    log "Player 2s deck: #{p2cards.join(", ")}"

    p1c = p1cards.shift
    p2c = p2cards.shift
    log "Player 1 plays: #{p1c}"
    log "Player 2 plays: #{p2c}"

    if p1c <= p1cards.size && p2c <= p2cards.size
      winner = play_game(p1cards[0...p1c], p2cards[0...p2c])
      if winner == 1
        p1cards.push p1c, p2c
      else
        p2cards.push p2c, p1c
      end
    elsif p1c > p2c
      p1cards.push p1c, p2c
    else
      p2cards.push p2c, p1c
    end
  end

  if p2cards.empty?
    puts "The winner of game #{game} is player 1!" #{players["Player 1:"].join(", ")}\n"
    return 1
  else
    puts "The winner of game #{game} is player 2!" #{players["Player 2:"].join(", ")}\n"
    return 2
  end
end

def part2(input)
  decks = input.split("\n\n").map do |ps|
    list = ps.split("\n")
    list[1..-1].map(&:to_i)
  end

  winner = play_game(decks[0], decks[1])

  decks[winner-1].reverse.map.with_index{|v,i| v*(i+1) }.sum
end

# p part2(File.read("sample2.txt"))
# p part2(File.read("sample3.txt"))
p part2(File.read("input.txt"))
