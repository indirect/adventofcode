def turn(side, dist, dir)
  return dir if dist.zero?

  case side
  when "R"
    case dir
    when "N"
      dir = "E"
    when "S"
      dir = "W"
    when "E"
      dir = "S"
    when "W"
      dir = "N"
    end
  when "L"
    case dir
    when "N"
      dir = "W"
    when "S"
      dir = "E"
    when "E"
      dir = "N"
    when "W"
      dir = "S"
    end
  end

  turn(side, dist-90, dir)
end

def distance_after(actions)
  x,y,dir = 0,0,"E"

  actions.each do |a|
    action, dist = a[0], a[1..-1].to_i
    p [x,y,dir, action, dist]

    case action
    when "N"
      y -= dist
    when "S"
      y += dist
    when "E"
      x += dist
    when "W"
      x -= dist
    when "L"
      dir = turn("L", dist, dir)
    when "R"
      dir = turn("R", dist, dir)
    when "F"
      case dir
      when "N"
        y -= dist
      when "S"
        y += dist
      when "E"
        x += dist
      when "W"
        x -= dist
      end
    end
  end

  x.abs + y.abs
end

p distance_after(File.read("sample.txt").split("\n"))
p distance_after(File.read("input.txt").split("\n"))
