#!/usr/bin/ruby

lines = File.read("input.txt").lines

require "set"
seen = Set.new
frequency = 0

catch :repeat do
  loop do
    lines.each do |line|
      frequency += line.to_i
      throw :repeat, frequency.to_s if seen.include?(frequency)
      seen.add(frequency)
    end
  end
end

puts frequency