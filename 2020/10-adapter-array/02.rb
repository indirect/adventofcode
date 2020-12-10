def jolt_diff(input)
  input.map!(&:to_i)

  chain = [0]
  adapter = input.select { |a| a <= (chain.last + 3) }.min
  until adapter.nil?
    chain.push adapter
    input.delete(adapter)
    adapter = input.select { |a| a <= (chain.last + 3) }.min
  end

  chain.push chain.last + 3

  chain
end

$counts = {}
def arrangements(input)
  return $counts[input] if $counts.key?(input)
  return 1 if input.size <= 3

  if (input[0] + 3) >= input[2]
    $counts[input] = arrangements(input.dup.tap{|i| i.delete_at(1) }) + arrangements(input[1..-1])
  else
    $counts[input] = arrangements(input[1..-1])
  end
end

chain = jolt_diff(File.read("sample.txt").split("\n"))
p arrangements(chain)

chain = jolt_diff(File.read("sample2.txt").split("\n"))
p arrangements(chain)

chain = jolt_diff(File.read("input.txt").split("\n"))
p arrangements(chain)
