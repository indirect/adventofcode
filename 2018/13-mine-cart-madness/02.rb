#!/usr/bin/ruby

test = File.read("test2.txt")
input = File.read("input.txt")

class Track
  attr_reader :carts, :track, :step

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
    
    puts inspect if @debug
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
    new_carts = []
    old_carts = carts.sort_by{|c| [c[1], c[0]] }
    
    until old_carts.empty?
      x, y, c, n = old_carts.shift

      case c
      when "<"
        nc = [x-1, y] + dir(x-1, y, c, n)
      when ">"
        nc = [x+1, y] + dir(x+1, y, c, n)
      when "^"
        nc = [x, y-1] + dir(x, y-1, c, n)
      when "v"
        nc = [x, y+1] + dir(x, y+1, c, n)
      end
      
      if (new_carts + old_carts).any?{|c| c[0..1] == nc[0..1] }
        new_carts.reject!{|c| c[0..1] == nc[0..1] }
        old_carts.reject!{|c| c[0..1] == nc[0..1] }
      else
        new_carts << nc
      end
    end
    
    @carts = new_carts
    @step += 1
    
    puts inspect if @debug
  end

  def inspect
    width = track.keys.map(&:first).max + 1
    height = track.keys.map(&:last).max + 1
    grid = Array.new(height) { Array.new(width, " ") }
    track.each{|(x,y), t| grid[y][x] = t }
    carts.each{|x,y,c,n| grid[y][x] = "\e[32m#{c}\e[0m" }

    [ "Step #{step}",
      grid.map(&:join).join("\n"),
      "Carts #{carts.inspect}",
    ].compact.join("\n").tap{|i| File.write("step_#{sprintf("%05d", @step)}.txt", i) }
  end
end

#t = Track.new(test, :debug)
t = Track.new(input)
t.advance until t.carts.size == 3
until t.carts.size == 1
  t.advance
  t.inspect if (t.step % 1000).zero?
end
p t