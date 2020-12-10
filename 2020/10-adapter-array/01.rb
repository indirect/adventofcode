def jolt_diff(input)
  input.map!(&:to_i)

  rating = 0
  adapter = input.select { |a| a <= (rating + 3) }.min
  counts = Hash.new(0)
  until adapter.nil?
    counts[adapter - rating] += 1
    rating = adapter
    input.delete(adapter)
    adapter = input.select { |a| a <= (rating + 3) }.min
  end

  counts[3] += 1
  p counts
  counts[1] * counts[3]
end

p jolt_diff(File.read("sample.txt").split("\n"))
p jolt_diff(File.read("sample2.txt").split("\n"))
p jolt_diff(File.read("input.txt").split("\n"))

