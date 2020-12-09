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

  p [input[i-size...i], valids, n]
  n
end

p first_invalid(File.read("sample.txt").split("\n"), size: 5)

p first_invalid(File.read("input.txt").split("\n"), size: 25)
