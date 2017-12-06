input = %w[10	3	15	10	5	15	5	15	9	2	5	8	5	2	3	6].map(&:to_i)

def distribute_blocks(banks)
  seen = {}

  until seen.has_key?(banks)
    seen[banks.dup] = true
    cycle(banks)
  end

  {final: banks, steps: seen.size}
end

def cycle(banks)
  blocks, index = banks.each.with_index.sort_by{|a,b| [-a, b] }.first

  banks[index] = 0

  while blocks > 0
    index = (index + 1) % banks.size
    banks[index] += 1
    blocks -= 1
  end
end


test_case = %w[0 2 7 0].map(&:to_i)
test_steps = distribute_blocks(test_case)[:steps]
raise "oh no, #{test_steps} steps" unless test_steps == 5

puts "part 1"
a1 = distribute_blocks(input)
puts a1[:steps]

puts "part 2"
a2 = distribute_blocks(a1[:final])
puts a2[:steps]
