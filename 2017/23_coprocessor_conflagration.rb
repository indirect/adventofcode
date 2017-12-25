input = DATA.read.chomp.split("\n")

def count_mul(instr)
  instr = instr.map{|l| l.split(" ") }
  registers = ("a".."h").to_a.map{|r| [r, 0] }.to_h
  cur = 0
  count_mul = 0

  while instr[cur]
    name, x, y = instr[cur]
    y = registers.has_key?(y) ? registers[y] : y.to_i
    x = registers.has_key?(x) ? x : x.to_i

    case name
    when "set"
      registers[x] = y
    when "sub"
      registers[x] -= y
    when "mul"
      count_mul += 1
      registers[x] *= y
    when "jnz"
      x = registers[x] if registers.has_key?(x)
      next cur += y unless x.zero?
    end

    cur += 1
  end

  count_mul
end

puts "part 1"
p count_mul(input)

def run(instr)
  instr = instr.map{|l| l.split(" ") }
  registers = ("a".."h").to_a.map{|r| [r, 0] }.to_h
  registers["a"] = 1
  cur = 0
  prev = {}

  while instr[cur]
    name, x, y = instr[cur]
    y = registers.has_key?(y) ? registers[y] : y.to_i
    x = registers.has_key?(x) ? x : x.to_i

    case name
    when "set"
      registers[x] = y
    when "sub"
      registers[x] -= y
    when "mul"
      registers[x] *= y
    when "jnz"
      x = registers[x] if registers.has_key?(x)
      next cur += y unless x.zero?
    end

    cur += 1
  end

  registers
end

puts "part 2"
# Rewriting the assembly into Ruby code:
<<-RUBY
h = 0
105_700.step(to: (105_700 + 17_000), by: 17) do |b|
  2.step(to: b) do |d|
    2.step(to: b) do |e|
      p "b: #{b}, d: #{d}, e: #{e}, h: #{h}"
      h += 1 if d * e == b
    end
  end
end
h
RUBY

# Rewriting the Ruby code into an extremely simplified form:
require "prime"
p 105_700.step(to: (105_700 + 17_000), by: 17).to_a.reject(&:prime?).count


__END__
set b 57
set c b
jnz a 2
jnz 1 5
mul b 100
sub b -100000
set c b
sub c -17000
set f 1
set d 2
set e 2
set g d
mul g e
sub g b
jnz g 2
set f 0
sub e -1
set g e
sub g b
jnz g -8
sub d -1
set g d
sub g b
jnz g -13
jnz f 2
sub h -1
set g b
sub g c
jnz g 2
jnz 1 3
sub b -17
jnz 1 -23
