input = DATA.read.chomp
directions = %i[up right down left]

class VirusGrid
  def self.infected_after(grid, bursts = 10_000, debug = false)
    new(grid, debug).tap{|g| bursts.times{ g.burst } }.infections
  end

  attr_reader :infections

  def initialize(grid_string, debug = false)
    @grid = grid_string.split("\n")
    @debug = debug

    @pos = [@grid.size/2, @grid[0].size/2]
    @dir = 0
    @infections = 0
    visualize if @debug
  end

  def turn_right
    @dir = (@dir + 1) % 4
  end

  def turn_left
    @dir = (@dir - 1) % 4
  end

  def infected?
    cur == "#"
  end

  def cur(val = nil)
    if val
      @grid[@pos[0]][@pos[1]] = val
    else
      @grid[@pos[0]][@pos[1]]
    end
  end

  def toggle_infection
    if infected?
      cur(".")
    else
      @infections += 1
      cur("#")
    end
  end

  def move
    case @dir
    when 0 # up
      @pos[0] -= 1
    when 1 # right
      @pos[1] += 1
    when 2 # down
      @pos[0] += 1
    when 3 # left
      @pos[1] -= 1
    end

    if @pos[0].zero?
      @grid.unshift("." * @grid.first.size)
      @pos[0] += 1
    end

    if @pos[1].zero?
      @grid.each{|l| l.prepend(".") }
      @pos[1] += 1
    end

    if @pos[0] == (@grid.size - 1)
      @grid.push("." * @grid.first.size)
    end

    if @pos[1] == (@grid.first.size - 1)
      @grid.each{|l| l.concat(".") }
    end
  end

  def burst
    infected? ? turn_right : turn_left
    toggle_infection
    move
    visualize if @debug
  end

  def visualize
    @grid.each.with_index do |line, i|
      line = line.gsub(/(.)/, '\1 ')
      if i == @pos[0]
        line[(@pos[1]*2)-1] = "["
        line[(@pos[1]*2)+1] = "]"
      end
      puts line
    end
    puts
  end
end

testcase = "..#\n#..\n..."

puts "part 1"
raise "oh no" unless VirusGrid.infected_after(testcase.dup, 70) == 41
p VirusGrid.infected_after(input)
puts


class EvolvedVirusGrid < VirusGrid

  def turn_around
    @dir = (@dir + 2) % 4
  end

  def burst
    case cur
    when "." # clean
      cur("W")
      turn_left
    when "W" # weakened
      cur("#")
      @infections += 1
      # do not turn
    when "#" # infected
      cur("F")
      turn_right
    when "F" # flagged
      cur(".")
      turn_around
    end

    move
    visualize if @debug
  end
end

puts "part 2"
raise "oh no" unless EvolvedVirusGrid.infected_after(testcase, 100) == 26
p EvolvedVirusGrid.infected_after(input, 10_000_000)

__END__
#..#...##.#.###.#.#.#...#
.####....#..##.#.##....##
...#..#.#.#......##..#..#
##.####.#.##........#...#
##.#....##..#.####.###...
#..#..###...#.#..##..###.
.##.##..#.####.#.#.....##
#....#......######...#...
..#.#.##.#..#...##.#.####
#.#..#.....#..####.#.#.##
...##.#..##.###.###......
###..#.####.#..#####..#..
...##.##.#.###.#..##.#.##
.####.#.##.#####.##.##..#
#.##.#...##.#.###.###..#.
..#.#..#..#..##..###...##
##.##.#..#.###....###..##
.#...###..#####.#..#.#.##
....##..####.##...#..#.##
#..#..###..#..###...#..##
.##.#.###..####.#.#..##.#
..###.#....#...###...##.#
.#...##.##.####...##.####
###.#.#.####.##.###..#...
#.#######.#######..##.#.#
