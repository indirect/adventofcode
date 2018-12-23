#!/usr/bin/ruby

test = File.read("test.txt")
input = File.read("input.txt")

class Track
  attr_reader :carts, :track, :step, :crashes

  def initialize(input, debug = false)
    @track = {}
    @carts = []
    @step = 0
    @debug = debug

    input.split("\n").each.with_index do |line, y|
      line.chars.each.with_index do |char, x|
        carts.push [x,y,char,"l"] if "<>^v".include?(char)
        char = "|" if "^v".include?(char)
        char = "-" if "<>".include?(char)
        track[[x,y]] = char
      end
    end
  end
  
  def dir(x, y, c, d)
    t = track[[x,y]]
    case t
    when "-", "|"
      [c, d]
    when "/"
      nc = {">" => "^", "<" => "v", "^" => ">", "v" => "<"}[c]
      [nc, d]
    when "\\"
      nc = {">" => "v", "<" => "^", "^" => "<", "v" => ">"}[c]
      [nc, d]
    when "+"
      case d
      when "l"
        nc = {">" => "^", "<" => "v", "^" => "<", "v" => ">"}[c]
        [nc, "s"]
      when "s"
        [c, "r"]
      when "r"
        nc = {">" => "v", "<" => "^", "^" => ">", "v" => "<"}[c]
        [nc, "l"]
      else
        raise "oh no #{t}: #{[x,y,c,d]}"
      end
    else
      raise "oh no, #{t}: #{[x,y,c,d]}"
    end
  end

  def advance
    carts.map! do |x, y, c, n|
      case c
      when "<"
        [x-1, y] + dir(x-1, y, c, n)
      when ">"
        [x+1, y] + dir(x+1, y, c, n)
      when "^"
        [x, y-1] + dir(x, y-1, c, n)
      when "v"
        [x, y+1] + dir(x, y+1, c, n)
      end
    end
    @step += 1
    coords=carts.map{|c| c[0..1]}
    @crashes = coords.select{|c| coords.count(c) > 1 }.uniq
    
#    puts inspect if @debug
  end
  
  def crash?
    @crashes && @crashes.any?
  end

  def inspect
    width = track.keys.map(&:first).max + 1
    height = track.keys.map(&:last).max + 1
    grid = Array.new(height) { Array.new(width, " ") }
    track.each{|(x,y), t| grid[y][x] = t }
    carts.each{|x,y,c,n| grid[y][x] = "\e[32m#{c}\e[0m" }
    crashes.each{|x,y,c,n| grid[y][x] = "\e[31mX\e[0m" } if crash?

    [ "Step #{step}",
      grid.map(&:join).join("\n"),
      "Carts #{carts.inspect}",
      crash? ? "Crashes at #{crashes.inspect}" : nil,
    ].compact.join("\n").tap{|i| File.write("step_#{sprintf("%03d", @step)}.txt", i) }
  end
end

t = Track.new(test, :debug)
t = Track.new(input, :debug)
t.advance until t.crash?
p t.crashes