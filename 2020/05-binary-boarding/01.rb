input = File.read("input.txt")

def seat_id(pass)
  row = choose(pass[0..6], range: 0..127, lower: "F")
  col = choose(pass[7..-1], range: 0..7, lower: "L")
  id = row * 8 + col
  {row: row, column: col, seat_id: id}
end

def choose(pass, range:, lower:, debug: false)
  p pass if debug
  pass.chars.inject(range) do |rows, l|
    if l == lower
      rows.begin..((rows.begin+rows.end)/2.0).floor
    else
      ((rows.begin+rows.end)/2.0).ceil..rows.end
    end.tap{|r| p [r,l] if debug }
  end.begin
end

# p choose("RLR", range: 0..7, lower: "L")

p seat_id("FBFBBFFRLR")
p seat_id("BFFFBBFRRR")
p seat_id("FFFBBBFRRR")

max = input.lines.map(&:chomp).map do |pass|
  seat_id(pass)[:seat_id]
end.max

p max
