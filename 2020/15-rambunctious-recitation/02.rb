def numbers(list, turns:)
  numbers = Hash.new{ Array.new }
  last = nil

  list.split(",").map(&:to_i).each.with_index do |n, i|
    last = n
    numbers[last] = [i,nil]
  end

  (numbers.size...turns).each do |i|
    speak = numbers[last].last ? numbers[last].first - numbers[last].last : 0
    numbers[speak] = [i, numbers[speak].first]
    last = speak
  end

  last
end

p numbers("0,3,6", turns: 10)
p numbers("0,3,6", turns: 2020)
# p numbers("0,3,6", turns: 30000000)

p numbers("20,0,1,11,6,3", turns: 30000000)
