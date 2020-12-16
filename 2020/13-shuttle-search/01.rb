def departure(notes)
  time = notes.first.to_i
  buses = notes.last.split(",").reject{|b| b == "x" }.map(&:to_i)

  earliest = buses.map do |b|
    n = time
    n += 1 until (n % b).zero?
    [b, n]
  end.sort_by(&:last).first

  (earliest.last - time) * earliest.first
end

p departure(File.read("sample.txt").split("\n"))
p departure(File.read("input.txt").split("\n"))
