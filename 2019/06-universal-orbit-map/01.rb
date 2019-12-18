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
end

sample = "COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L"
Orbits.new(sample).total  # => 42

input = File.read("input.txt")
Orbits.new(input).total  # => 142497
