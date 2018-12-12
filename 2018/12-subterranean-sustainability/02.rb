#!/usr/bin/ruby

input = File.read("test.txt").split("\n")
input = File.read("input.txt").split("\n")
state = "...." << input.shift.split(": ").last << "...."
rules = input[1..-1].map{|r| r.split(" => ") }.to_h

buffer = 4
last = state.chars.map.with_index{|v,i| (v == "#" ? (i - buffer) : 0) }.sum
results = []
i = 0

loop do
  new_state = ["."] * 4
  (0..(state.size-5)).each do |i|
    rule = rules.find{|p,r| state[i..i + 4] == p }
    new_state[i + 2] = rule ? rule.last : "."
  end
  state = new_state.join
  state << "." until state.end_with?("....")
  (state.prepend("."); buffer += 1) until state.start_with?("....")

  sum = state.chars.map.with_index{|v,i| (v == "#" ? (i - buffer) : 0) }.sum
  diff = sum - last
  last = sum
  
  results << [i, sum, diff]
  
  next unless results.size > 3
  recent = results[-3..-1].map(&:last)
  if recent.uniq.size == 1
    puts "After step #{i}, the per-step change is #{diff}"
    break
  end
  
  i += 1
end

p results.last[1] + (50_000_000_000 - results.size) * results.last[2]
