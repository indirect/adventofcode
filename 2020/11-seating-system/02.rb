def extend(i, dir)
  if dir < 1
    i - 1
  elsif dir > 1
    i + 1
  else
    i
  end
end

def seat(r, s, seats)
  return nil if r < 0 || s < 0
  return nil if r >= seats.size || s >= seats.first.size
  seats.dig(r,s)
end

def surround(ri, si, seats)
  [ri-1, ri, ri+1].map.with_index do |r, rr|
    [si-1, si, si+1].map.with_index do |s, ss|
      next if r == ri && s == si

      nr = r
      ns = s
      v = seat(nr,ns,seats)
      # p [r,s,v] if ri == $ri && si == $si

      until v != "."
        nr = extend(nr, rr)
        ns = extend(ns, ss)
        v = seat(nr, ns, seats)
        # p [r,s,v] if ri == $ri && si == $si
      end

      v
    end
  end.tap{|s| p s if ri == $ri && si == $si }.flatten.compact
end

def step(seats)
  seats.map.with_index do |r, ri|
    r.map.with_index do |s, si|
      neighbors = surround(ri, si, seats)

      case s
      when "L"
        neighbors.include?("#") ? s : "#"
      when "#"
        neighbors.count("#") >= 5 ? "L" : s
      else
        s
      end
    end
  end.tap do |ss|
    if $show
      sp = ss.map(&:dup)
      sp[$ri][$si] = "@"
      puts sp.map(&:join) << "\n"
      # puts ss.map(&:join) << "\n"
    end
  end
end

def count(seats)
  previous = nil

  until previous == seats
    previous = seats
    seats = step(seats)
  end

  seats.map{|l| l.count("#") }.sum
end

# $show = true
# $ri, $si = 1, 8
p count(File.read("sample.txt").split("\n").map{|l| l.chars })
p count(File.read("input.txt").split("\n").map{|l| l.chars })
