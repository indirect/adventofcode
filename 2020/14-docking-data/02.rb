def apply_mask(mask, val, mem, loc)
  mask = mask.chars

  loc = ("%036b" % loc).chars.zip(mask).map do |v, m|
    m == "0" ? v : m
  end.join

  locs = [loc]
  while locs.any?{|l| l.include?("X") }
    locs.map! do |loc|
      [loc.sub("X", "0"), loc.sub("X", "1")]
    end
    locs.flatten!
  end
  locs.map{|loc| mem[loc.to_i(2)] = val }
end

def run(program)
  mask = nil
  mem = {}

  program.each do |line|
    # p line
    loc, val = line.split(" = ")
    if loc == "mask"
      mask = val
    else
      loc = loc[4..-2].to_i
      apply_mask(mask, val.to_i, mem, loc)
    end
    # p mem
  end

  mem.values.sum
end

p run(File.read("sample2.txt").split("\n"))
p run(File.read("input.txt").split("\n"))
