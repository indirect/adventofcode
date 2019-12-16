input = File.read("input.txt")

def run_intcode(program)
  ints = program.chomp.split(",").map(&:to_i)
  ip = 0

  until 99 == ints[ip]
    value = ints[ip]
    opcode = value % 100
    mode_list = value / 100
    mode = mode_list.zero? ? [] : mode_list.to_s.chars.reverse.map{|c| c == "1" }

    case opcode
    when 1 # add
      a = get(ints, ip+1, mode[0])
      b = get(ints, ip+2, mode[1])
      dest = ints[ip+3]
      ints[dest] = a + b
      ip += 4
    when 2 # multiply
      a = get(ints, ip+1, mode[0])
      b = get(ints, ip+2, mode[1])
      dest = ints[ip+3]
      ints[dest] = a * b
      ip += 4
    when 3 # input
      set(ints, ip+1, mode[0], input)
      ip += 2
    when 4 # output
      output get(ints, ip+1, mode[0])
      ip += 2
    else
      raise "oh no, got #{ints[ip]} at position #{ip}"
    end
  end

  puts "Complete: #{ints.first}"
end

def get(ints, addr, mode)
  mode ? ints[addr] : ints[ints[addr]]
end

def set(ints, addr, mode, value)
  mode ? ints[addr] = value : ints[ints[addr]] = value
end

def input
  1
end

def output(value)
  puts "Output: #{value}"
end

run_intcode "3,0,4,0,99"
run_intcode "1002,4,3,4,33"

run_intcode input

# >> Output: 1
# >> Complete: 1
# >> Complete: 1002
# >> Output: 0
# >> Output: 0
# >> Output: 0
# >> Output: 0
# >> Output: 0
# >> Output: 0
# >> Output: 0
# >> Output: 0
# >> Output: 0
# >> Output: 11193703
# >> Complete: 3

