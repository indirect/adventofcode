#!/usr/bin/ruby

input = File.read("test.txt").split("\n")
input = File.read("input.txt").split("\n")
state = "...." << input.shift.split(": ").last << "...."
rules = input[1..-1].map{|r| r.split(" => ") }.to_h

puts "     " << state

buffer = 4
1000.times do |i|
  new_state = ["."] * 4
  (0..(state.size-5)).each do |i|
    rule = rules.find{|p,r| state[i..i + 4] == p }
    new_state[i + 2] = rule ? rule.last : "."
  end
  state = new_state.join
  state << "." until state.end_with?("....")
  (state.prepend("."); buffer += 1) until state.start_with?("....")
#  puts "#{sprintf("%03d", i+1)}: #{state} #{state.chars.map.with_index{|v,i| (v == "#" ? (i - buffer) : 0) }.sum} (#{buffer})"
  puts "#{sprintf("%03d", i+1)}: #{state.chars.map.with_index{|v,i| (v == "#" ? (i - buffer) : 0) }.sum} (#{buffer})"
end

