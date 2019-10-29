input = File.read("input.txt")
# input = File.read("test5.txt")

Unit = Struct.new(:x, :y, :kind, :hp) do
  def xy; [x, y]; end
  def xy=(c); self.x = c[0]; self.y = c[1]; end
end

module Enumerable
  def read_sort
    sort_by { |(x, y)| [y, x] }
  end
end

class Astar
  Node = Struct.new(:xy, :distance, :heuristic, :parent) do
    def cost; distance + heuristic; end
  end

  attr_reader :map, :src, :dest, :path
  attr_accessor :open_list, :closed_list

  def initialize(map, src, dest)
    @map = map
    @src = src
    @dest = dest
    @path = find_path
  end

  def find_path
    open_list = [Node.new(src, 0, 0)]
    closed_list = []
    current = nil

    until open_list.empty?
      current = open_list.min_by(&:cost)
      closed_list.push open_list.delete(current)

      break if current.xy == dest

      nearby = @map.around(current.xy).
        select { |xy| @map[xy] == "." }.
        reject { |xy| closed_list.any? { |n| n.xy == xy } }

      nearby.each do |xy|
        earlier = open_list.find { |n| n.xy == xy }
        if earlier
          if (current.distance + 1) < earlier.distance
            earlier.parent = current
            earlier.distance = current.distance + 1
          end
        else
          open_list << Node.new(
            xy,
            current.distance + 1,
            @map.heuristic(xy, dest),
            current
          )
        end
      end
    end

    if current.xy == dest
      [current].tap { |path| path.unshift(path.first.parent) until path.first.parent.nil? }
    end
  end

  def result
    if path&.last&.xy == dest
      [path.last.distance, path[1].xy]
    else
      nil
    end
  end
end

class Map
  def initialize(input)
    @rows = input.split("\n").map(&:chars)
  end

  def each_row(&block)
    @rows.each(&block)
  end

  def inspect
    @rows.map(&:join).join("\n")
  end

  def [](c)
    @rows[c[1]][c[0]]
  end

  def []=(c, v)
    @rows[c[1]][c[0]] = v
  end

  def around(t)
    [[t[0], t[1] + 1], [t[0], t[1] - 1], [t[0] + 1, t[1]], [t[0] - 1, t[1]]].
      select { |(x, y)| x >= 0 && y >= 0 }
  end

  def mdist(src, dest)
    (src[0] - dest[0]).abs + (src[1] - dest[1]).abs
  end

  def heuristic(src, dest)
    (src[0] - dest[0]).abs ** 2 + (src[1] - dest[1]).abs ** 2
  end
end

class Cave
  attr_reader :map

  def initialize(input)
    @map = Map.new(input)
    @units = []

    @map.each_row.with_index do |row, y|
      row.each.with_index do |char, x|
        @units << Unit.new(x, y, char, 200) if %w[G E].include?(char)
      end
    end

    @step = 0
  end

  def elves
    @units.select { |u| u.kind == "E" }
  end

  def goblins
    @units.select { |u| u.kind == "G" }
  end

  def sorted_units
    @units.sort_by { |u| [u.y, u.x] }
  end

  def outcome
    combat
    @step * @units.map(&:hp).inject(:+)
  end

  def debug
    puts "\e[2J" # clear the screen
    puts "After #{@step} rounds:"
    puts map.inspect
    puts
  end

  def combat
    catch :done do
      loop do
        debug if ENV["DEBUG"]

        sorted_units.each { |u| move(u) }

        @step += 1
      end
    end

    puts "End result, in the middle of round #{@step + 1}:"
    puts map.inspect
    puts @step * @units.map(&:hp).inject(:+)
  end

  def targets(u)
    u.kind == "E" ? goblins : elves
  end

  def move(u)
    in_range = targets(u).flat_map do |t|
      @map.around([t.x, t.y])
    end.read_sort

    return attack(u) if in_range.include?(u.xy)
    throw :done if in_range.empty?

    open_in_range = in_range.select { |c| @map[c] == "." }
    distances = open_in_range.map do |(x, y)|
      [x, y, *Astar.new(@map, [u.x, u.y], [x, y]).result]
    end.select { |(x, y, d)| d }

    return if distances.empty?

    min = distances.map { |(x, y, d)| d }.min
    dest = distances.select { |(x, y, d)| d == min }.read_sort.first.last

    @map[u.xy] = "."
    @map[dest] = u.kind
    u.xy = dest

    attack(u) if in_range.include?([u.x, u.y])
  end

  def attack(u)
    adj = @map.around([u.x, u.y])
    targets_in_range = targets(u).
      select { |t| adj.include?([t.x, t.y]) }.
      sort_by! { |t| [t.hp, t.y, t.x] }

    return if targets_in_range.empty?

    target = targets_in_range.first
    target.hp -= 3

    if target.hp <= 0
      @map[target.xy] = "."
      @units.delete(target)
    end
  end

  def inspect
    "#<Cave @step=#{@step} @elves=#{elves.count} @goblins=#{goblins.count}>"
  end
end

# Cave.new("#########
# #G......#
# #.E.#...#
# #..##..G#
# #...##..#
# #...#...#
# #.G...G.#
# #.....G.#
# #########").outcome == 18740 || raise("oh no not 18740")
# Cave.new("#######
# #.E...#
# #.#..G#
# #.###.#
# #E#G#G#
# #...#G#
# #######").outcome == 28944 || raise("oh no, not 28944")

c = Cave.new(input)

if RUBY_ENGINE == "ruby"
  Signal.trap("INFO") { puts c.debug }
end

p c.outcome

binding.pry
puts "done"
