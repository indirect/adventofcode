#!/usr/bin/env ruby

def count_sum(filename)
  input = File.read(filename + ".txt")

  input.split("\n\n").map do |g|
    g.split("\n").map(&:chars).inject(&:&).count
  end.sum
end

p count_sum("sample")
p count_sum("input")
