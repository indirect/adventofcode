#!/usr/bin/ruby

puts File.read("input.txt").lines.inject(0){|s,l| s + l.to_i }