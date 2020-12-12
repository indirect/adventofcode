def turn(side, dist, wpx, wpy)
  p [side, dist, wpx, wpy]
  return wpx, wpy if dist.zero?

  case side
  when "L"
    nwpx = wpy
    nwpy = wpx * -1
  when "R"
    nwpx = wpy * -1
    nwpy = wpx
  end

  turn(side, dist-90, nwpx, nwpy)
end

def distance_after(actions)
  x,y,dir = 0,0,"E"
  wpx,wpy = 10,-1

  actions.each do |a|
    action, dist = a[0], a[1..-1].to_i
    # p [x,y,dir, wpx,wpy, action, dist]

    case action
    when "N"
      wpy -= dist
    when "S"
      wpy += dist
    when "E"
      wpx += dist
    when "W"
      wpx -= dist
    when "L"
      wpx, wpy = turn("L", dist, wpx, wpy)
    when "R"
      wpx, wpy = turn("R", dist, wpx, wpy)
    when "F"
      dist.times do
        x += wpx
        y += wpy
      end
    end
  end

  p [x,y,dir, wpx, wpy]
  x.abs + y.abs
end

p distance_after(File.read("sample.txt").split("\n"))
p distance_after(File.read("input.txt").split("\n"))
