def numbers(list, turns:)
  numbers = list.split(",").map(&:to_i).reverse

  (turns - numbers.size).times.map do
    if numbers.count(numbers.first) == 1
      numbers.unshift 0
    else
      numbers.unshift numbers[1..-1].index(numbers.first) + 1
    end
  end

  numbers.first
end

p numbers("0,3,6", turns: 10)
p numbers("0,3,6", turns: 2020)

p numbers("20,0,1,11,6,3", turns: 2020)
