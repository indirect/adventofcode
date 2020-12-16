def departure(notes)
  buses = notes.last.split(",").map(&:to_i).reverse.each.with_index.reject{|i| i.first.zero? }

  j, x = buses.shift
  while buses.any?
    b, i = buses.shift
    x += j until (x % b) == (i % b)
    j *= b
  end

  x - i
end

def departure(notes)
  buses = notes.last.split(",").map(&:to_i).reverse.each.with_index.reject{|i| i.first.zero? }
  puts notes

  j, x = buses.shift
  while buses.any?
    b, i = buses.shift

    until (x % b) == (i % b)
      x += j
      puts "#{x-j} + #{j} = #{x} mod #{b} -> #{x%b} (want #{i})"
    end

    puts "  #{j} * #{b} = #{j*b}"
    j *= b
  end

  x - i
end

# p departure(["5,4,x,x,3"])
p departure(["17,x,13,19"])
# p departure(["67,7,59,61"])
# p departure(["1789,37,47,1889"])

# p departure(File.read("sample.txt").split("\n"))
# p departure(File.read("input.txt").split("\n"))
