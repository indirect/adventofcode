#!/usr/bin/env ruby

class Orbits

  def initialize(input)
    @list = {}
    input.chomp.split("\n").map{|l| l.split(")") }.each do |l,r|
      @list[r] = l
    end
    @list
  end

  def count(key)
    key == "COM" ? 0 : count(@list[key]) + 1
  end

  def total
    @list.keys.map{|k| count(k) }.sum
  end

  def orbits(key)
    orbits = {}
    count = 0
    until key == "COM"
      key = @list[key]
      orbits[key] = count
      yield key, count if block_given?
      count += 1
    end
    orbits
  end

  def transfers(source, target)
    orbits(source) do |skey, sdist|
      orbits(target) do |tkey, tdist|
        return sdist + tdist if skey == tkey
      end
    end

    raise "oh no"
  end

end

sample = "COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L\nK)YOU\nI)SAN"
Orbits.new(sample).transfers("YOU", "SAN")  # => 4

input = File.read("input.txt")
Orbits.new(input).transfers("YOU", "SAN")  # => 301
