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
steps = input.map{|l| l[5] }.sort.uniq

order = ""
second = 0
next_letters = steps.find_all{|l| deps[l].empty? }
workers = Array.new(5){ Hash.new(0) }

def time(letter)
  letter.getbyte(0) - 64 + 60
end

while next_letters.any? || workers.any?(&:any?)
#  p [second, workers, order]
  second += 1 if workers.any?(&:any?)
  workers.each{|w| w.keys.each{|k| w[k] += 1 } }

  workers.each do |w|
    w.each do |k,v|
      if v >= time(k)
        deps.each{|l, ds| ds.delete(k) }
        w.delete(k)
        order << k
      end
    end
  end

  next_letters.push *deps.keys.sort.find_all{|l| deps[l].empty? }
  next_letters.sort!
  next_letters.uniq!

  workers.find_all(&:empty?).each do |w|
    next if next_letters.empty?
    next_letter = next_letters.shift
    deps.delete(next_letter)
    w[next_letter] = 0
  end
  
#  sleep 0.25
end

puts order
p second