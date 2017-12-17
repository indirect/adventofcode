require "yaml"
require "./10_knot_hash"

class DiskGrid
  def self.for_key(input)
    name = "../14_disk_defragmentation/#{input}.yml"
    file = File.expand_path(name, __FILE__)
    return new(YAML.load_file(file)) if File.file?(file)

    grid = (0..127).map do |i|
      hex = KnotHash.hash([input, i].join("-"))
      binary = hex.chars.map{|c| "%04d" % c.hex.to_s(2) }.join
      binary.chars.map(&:to_i)
    end
    File.write(file, grid.to_yaml)

    new grid
  end

  attr_reader :grid, :region_map, :cell_map, :region_counter

  def initialize(grid)
    @grid = grid
    @region_map = {}
    @cell_map = Hash.new{|h,k| h[k] = [] }
    @region_counter = 0
  end

  def usage
    grid.map{|r| r.count(1) }.sum
  end

  def visualize(regions: false)
    find_regions if regions

    grid.each.with_index do |elements, row|
      elements.each.with_index do |element, col|
        if regions
          region = region_map[[row, col]]
          print(region ? "%2d" % region : " .")
        else
          print(element.zero? ? " ." : " #")
        end
      end
      print "\n"
    end
  end

  def regions
    find_regions
    region_map.values.uniq.sort
  end

private

  def find_regions
    return unless region_counter.zero?

    grid.each.with_index do |cells, row|
      cells.each.with_index do |cell, col|
        # For each cell that is used,
        next if cell.zero?

        # check each adjacent cell for an existing region,
        region = adj_reg(row, col).first

        if region
          # and use that region if one is found.
          region_map[[row, col]] = region
          cell_map[region].push([row, col])
        else # If no region is found,
          # start a new region
          @region_counter += 1
          # and mark these coordinates as that region.
          region_map[[row, col]] = region_counter
          cell_map[region_counter].push([row, col])
        end
      end
    end

    # now that all cells have a region, for every cell
    region_map.each do |(row, col), current|
      # if a different region is adjacent
      other = adj_reg(row, col).
        reject{|r| r == current }.first
      next if other.nil?

      # mark every cell in the second region
      cell_map[current].each do |a|
        # as belonging to the first region
        region_map[a] = other
        cell_map[other].push(a)
      end
      cell_map.delete(current)
    end
  end

  def adj(r, c)
    [[-1,  0], [ 0, -1], [ 0,  1], [ 1,  0]].map{|x,y| [x+r, y+c] }
  end

  def adj_reg(row, col)
    neighbors = adj(row, col).reject{|r, c| grid[r].nil? || grid[r][c].nil? || grid[r][c].zero? }
    neighbors.map{|c| region_map[c] }.compact
  end
end

if $0 == __FILE__
  input = DiskGrid.for_key("ljoxqyyw")
  testcase = DiskGrid.for_key("flqrgnkx")

  puts "part 1"
  raise "oh no" unless testcase.usage == 8108
  p input.usage

  puts "part 2"
  raise "oh no" unless testcase.regions.count == 1242
  p input.regions.count
end
