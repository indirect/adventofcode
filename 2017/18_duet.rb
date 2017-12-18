input = DATA.read.chomp.split("\n").map{|l| l.split(" ") }
test = <<-END.chomp.split("\n").map{|l| l.split(" ") }
set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2
END

def run(instr)
  registers = Hash.new(0)
  cur = 0
  snd = nil

  while instr[cur]
    name, x, y = instr[cur]
    y = registers.has_key?(y) ? registers[y] : y.to_i
    unless %w[set add mul mod].include?(name)
      x = registers.has_key?(x) ? registers[x] : x.to_i
    end

    case name
    when "snd"
      snd = x
    when "set"
      registers[x] = y
    when "add"
      registers[x] += y
    when "mul"
      registers[x] *= y
    when "mod"
      registers[x] = registers[x] % y
    when "rcv"
      return snd unless x.zero?
    when "jgz"
      next cur += y if x > 0
    end

    cur += 1
  end
end

puts "part 1"
raise "oh no" unless run(test) == 4
p run(input)

class Program
  attr_reader :id, :cur, :instr, :registers, :send, :recv, :sent

  def initialize(instr, id:, send:, recv:)
    @id = id

    @registers = Hash.new(0)
    @registers["p"] = id

    @cur = 0
    @instr = instr

    @send = send
    @recv = recv
    @sent = []
  end

  def done?
    instr[cur].nil? || (@waiting && recv.empty?)
  end

  def blocked?
    @waiting && recv.empty?
  end

  def step
    return if instr[cur].nil?

    name, x, y = instr[cur]
    y = registers.has_key?(y) ? registers[y] : y.to_i if y
    unless %w[set add mul mod rcv].include?(name)
      x = registers.has_key?(x) ? registers[x] : x.to_i
    end

    case name
    when "snd"
      sent.push x
      send.push x
    when "set"
      registers[x] = y
    when "add"
      registers[x] += y
    when "mul"
      registers[x] *= y
    when "mod"
      registers[x] = registers[x] % y unless y.zero?
    when "rcv"
      return @waiting = true if recv.empty?
      @waiting = false
      registers[x] = recv.pop
    when "jgz"
      return @cur += y if x > 0
    end

    @cur += 1
  end
end

def run_two(instr)
  q0 = Queue.new
  q1 = Queue.new

  p0 = Program.new(instr, id: 0, send: q0, recv: q1)
  p1 = Program.new(instr, id: 1, send: q1, recv: q0)

  until p0.done? && p1.done?
    p0.step
    p1.step
  end

  return p0, p1
end

test = <<-END.chomp.split("\n").map{|l| l.split(" ") }
snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d
END

puts "part 2"
raise "oh no" unless run_two(test).last.sent.size == 3
p run_two(input).last.sent.size

__END__
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 622
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19
