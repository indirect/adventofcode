def surround(ri, si, seats)
  [ri-1, ri, ri+1].map do |i|
    [si-1, si, si+1].map do |s|
      seats.dig(i, s) unless i < 0 || s < 0 || ri == i && si == s
    end
  end.flatten.compact#.tap{|s| p s if ri.zero? && si.zero? }
end

def step(seats)
  seats.map.with_index do |r, ri|
    r.map.with_index do |s, si|
      neighbors = surround(ri, si, seats)
      # p neighbors if ri.zero? && si.zero?

      case s
      when "L"
        neighbors.include?("#") ? s : "#"
      when "#"
        neighbors.count("#") >= 4 ? "L" : s
      else
        s
      end
    end
  end#.tap{|ss| puts ss.map(&:join); puts }
end

def count(seats)
  previous = nil

  until previous == seats
    previous = seats
    seats = step(seats)
    # puts seats.map(&:join); puts
  end

  seats.map{|l| l.count("#") }.sum
end

p count(File.read("sample.txt").split("\n").map{|l| l.chars })
p count(File.read("input.txt").split("\n").map{|l| l.chars })
