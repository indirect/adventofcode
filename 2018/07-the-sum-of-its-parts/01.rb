#!/usr/bin/ruby

input = File.read("input.txt").split("\n")

#input = %Q"Step C must be finished before step A can begin.
#Step C must be finished before step F can begin.
#Step A must be finished before step B can begin.
#Step A must be finished before step D can begin.
#Step B must be finished before step E can begin.
#Step D must be finished before step E can begin.
#Step F must be finished before step E can begin.".split("\n")

deps = Hash.new{|h,k| h[k] = [] }

input.each{|l| deps[l[36]] << l[5] }

p deps

order = ""
next_letters = ("A".."Z").find_all{|l| deps[l].empty? }

until next_letters.empty?
  next_letter = next_letters.shift
  order << next_letter
  deps.delete(next_letter)

  deps.each do |l, ds|
    ds.delete(next_letter)
  end
  
  next_letters.push *deps.keys.sort.find{|l| deps[l].empty? }
  next_letters.sort!
  next_letters.uniq!
end

puts order
