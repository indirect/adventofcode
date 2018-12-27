# input = File.read("input.txt")
input = File.read("test5.txt")

Unit = Struct.new(:x, :y, :kind, :hp)

module Enumerable
  def read_sort
    sort_by { |(x, y)| [y, x] }
  end
end

class Cave
  def initialize(input)
    @map = input.split("\n").map(&:chars)
    @units = []

    @map.each.with_index do |row, y|
      row.each.with_index do |char, x|
        @units << Unit.new(x, y, char, 200) if %w[G E].include?(char)
      end
    end

    @step = 0
  end

  def elves
    @units.select{ |u| u.kind == "E" }
  end

  def goblins
    @units.select{ |u| u.kind == "G" }
  end

  def sorted_units
    @units.sort_by { |u| [u.y, u.x] }
  end

  def step
    catch :done do
      sorted_units.each do |u|
        move(u)
      end
    end

    @step += 1
  end

  def targets(u)
    u.kind == "E" ? goblins : elves
  end

  def move(u)
    in_range = targets(u).flat_map do |t|
      around([t.x, t.y])
    end.read_sort

    return attack(u) if in_range.include?([u.x, u.y])

    open_in_range = in_range.select { |(x, y)| @map[y][x] == "." }
    distances = open_in_range.map do |(x, y)|
      [x, y, *dist([u.x, u.y], [x, y])]
    end.select { |(x, y, d)| d }

    return if distances.empty?

    min = distances.map { |(x, y, d)| d }.min
    dest = distances.select { |(x, y, d)| d == min }.read_sort.first.last

    @map[u.y][u.x] = "."
    @map[dest[1]][dest[0]] = u.kind
    u.x = dest[0]
    u.y = dest[1]

    attack(u) if in_range.include?([u.x, u.y])
  end

  def attack(u)
    adj = around([u.x, u.y])
    targets_in_range = targets(u).
      select{|t| adj.include?([t.x,t.y]) }.
      sort_by!{|t| [t.hp, t.y, t.x] }

    return if targets_in_range.empty?

    target = targets_in_range.first
    target.hp -= 3

    if target.hp <= 0
      @map[target.y][target.x] = "."
      @units.delete(target)
    end
  end

  def at(c)
    @map[c[1]][c[0]]
  end

  def around(t)
    [[t[0], t[1] + 1], [t[0], t[1] - 1], [t[0] + 1, t[1]], [t[0] - 1, t[1]]]
  end

  def mdist(src, dest)
    (src[0] - dest[0]).abs + (src[1] - dest[1]).abs
  end

  def dist(src, dest)
    binding.pry if @step > 24 && dest == [5,5]

    src_path = [src]
    dest_path = [dest]
    rejects = []

    until mdist(src_path.last, dest_path.first) == 1
      src_options = around(src_path.last).select { |c| at(c) == "." }.
        reject { |o| src_path.include?(o) || rejects.include?(o) }
      dest_options = around(dest_path.first).select { |c| at(c) == "." }.
        reject { |o| dest_path.include?(o) || rejects.include?(o) }

      return nil if src_options.empty? && dest_options.empty?

      if src_options.any?
        src_next = src_options.
          map { |o| o + [mdist(o, dest_path.first)] }.
          sort_by { |(x, y, d)| [d, y, x] }
        src_path.push src_next.shift[0..1]
        rejects.push *src_next
        break if mdist(src_path.last, dest_path.first) == 1
      elsif src_path.size > 1
        rejects.push(src_path.pop)
      end

      if dest_options.any?
        dest_next = dest_options.
          map { |o| o + [mdist(o, src_path.last)] }.
          sort_by { |(x, y, d)| [d, y, x] }
        dest_path.unshift dest_next.shift[0..1]
        rejects.push *dest_next
      elsif dest_path.size > 1
        rejects.push(dest_path.shift)
      end
    end

    found_dist = (src_path.size + dest_path.size) - 1
    next_step = src_path[1] || dest
    [found_dist, next_step]
  end

  def map
    @map.map(&:join).join("\n")
  end

  def inspect
    "#<Cave @step=#{@step} @elves=#{elves.count} @goblins=#{goblins.count}>"
  end
end

c = Cave.new(input)

27.times do
  c.step
  p c
  puts c.map
end
