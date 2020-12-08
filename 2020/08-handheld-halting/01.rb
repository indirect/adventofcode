def run(name)
  lines = File.read(name+".txt").split("\n")

  acc = 0
  ip = 0
  history = []
  until history.include?(ip)
    history << ip
    op, arg = lines[ip].split(" ")
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

  acc
end

p run("sample")
p run("input")
