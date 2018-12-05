#!/usr/bin/ruby

def reduce(str)
  done = false

  until done
    str.bytes.each_cons(2).with_index do |(a,b), i|
      if (a-b).abs == 32
        str.slice!(i, 2)
        break
      end
      
      done = true if i == (str.size - 2)
    end
  end

  str
end

puts reduce("dabAcCaCBAcCcaDA").size

puts reduce(File.read("input.txt")).size