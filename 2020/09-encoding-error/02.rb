def first_invalid(input, size:)
  input.map!(&:to_i)

  valids = input[0...size].combination(2).map(&:sum).uniq.sort

  i = size
  n = input[i]
  while valids.include?(n)
    i += 1
    valids = input[i-size...i].combination(2).map(&:sum).uniq.sort
    n = input[i]
  end

  # p [input[i-size...i], valids, n]
  n
end

def weakness(input, size:)
  invalid = first_invalid(input, size: size)

  2.upto(input.size) do |i|
    input.each_cons(i) do |range|
      # p range
      return (range.min + range.max) if (range.sum == invalid)
    end
  end
end

p weakness(File.read("sample.txt").split("\n"), size: 5)

p weakness(File.read("input.txt").split("\n"), size: 25)

