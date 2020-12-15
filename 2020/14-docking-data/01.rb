def apply_mask(mask, val)
  ("%036b" % val).chars.zip(mask.chars).map do |v, m|
    m == "X" ? v : m
  end.join.to_i(2)
end

def run(program)
  mask = nil
  mem = []

  program.each do |line|
    loc, val = line.split(" = ")
    if loc == "mask"
      mask = val
    else
      loc = loc[4..-2].to_i
      mem[loc] = apply_mask(mask, val.to_i)
    end
  end

  mem.compact.sum
end

p run(File.read("sample.txt").split("\n"))
p run(File.read("input.txt").split("\n"))
