#!/usr/bin/ruby

events = File.read("input.txt").split("\n").sort

guards = Hash.new{|h,k| h[k] = Array.new(60, 0) }

def minute_of(event)
  event.match(/:(\d\d)\]/)[1].to_i
end

id = nil
slept_at = nil
woke_at = nil

events.each do |event|
  case event
  when /Guard #(.+) begins shift/
    id = $1.to_i
  when /falls asleep/
    slept_at = minute_of(event)
  when /wakes up/
    woke_at = minute_of(event)
    (slept_at..woke_at).each do |minute|
      guards[id][minute] += 1
    end
  end
end

most_sleep = guards.map{|id, slept| [id, slept.inject(:+)] }.max_by{|id, slept| slept }.first
times_asleep = guards[most_sleep].each.with_index.max_by{|count, minute| count }.last

puts most_sleep * times_asleep