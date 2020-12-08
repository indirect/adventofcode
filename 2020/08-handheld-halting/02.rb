def run(lines)
  acc = 0
  ip = 0
  history = []
  until history.include?(ip) || ip >= lines.size
    history << ip
    op, arg = lines[ip].split(" ")
    # p [op, arg]
    case op
    when "nop"
      ip += 1
    when "acc"
      acc += arg.to_i
      ip += 1
    when "jmp"
      ip += arg.to_i
    end
  end

  ip >= lines.size && acc
end

def repair(name)
  lines = File.read(name+".txt").split("\n")

  acc = 0
  lines.each.with_index.find do |l, li|
    case l
    when /^nop/
      acc = run(lines.dup.tap{|ls| ls[li] = l.gsub("nop", "jmp") })
    when /^jmp/
      acc = run(lines.dup.tap{|ls| ls[li] = l.gsub("jmp", "nop") })
    end
  end

  acc
end

p repair("sample")
p repair("input")
