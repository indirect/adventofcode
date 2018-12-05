#!/usr/bin/ruby

def reduce(str)
  done = false

  until done
    done = true

    i = 0
    while i < (str.size - 1) do
      a = str.getbyte(i)
      b = str.getbyte(i + 1)
      
      if a.nil? || b.nil?
        p [i, a, b, str.size]
      end

      if (a-b).abs == 32
        done = false
        str.slice!(i, 2)
      else 
        i += 1
      end
    end
  end

  str
end

def sub_reduce(str, letter)
  str = str.delete(letter.upcase + letter.downcase)
  reduce(str)
end

str = "dabAcCaCBAcCcaDA"
str = File.read("input.txt")

lens = str.downcase.chars.sort.uniq.map do |letter|
  p [letter, sub_reduce(str, letter).size]
end.to_h

p lens.sort_by{|c,l| l }