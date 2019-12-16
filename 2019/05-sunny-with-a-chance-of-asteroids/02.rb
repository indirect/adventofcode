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
    when 5 # jump if true
      a = get(ints, ip+1, mode[0])
      if !a.zero?
        ip = get(ints, ip+2, mode[1])
      else
        ip += 3
      end
    when 6 # jump if false
      a = get(ints, ip+1, mode[0])
      if a.zero?
        ip = get(ints, ip+2, mode[1])
      else
        ip += 3
      end
    when 7 # less than
      a = get(ints, ip+1, mode[0])
      b = get(ints, ip+2, mode[1])
      value = a < b ? 1 : 0
      set(ints, ip+3, mode[2], value)
      ip += 4
    when 8 # equals
      a = get(ints, ip+1, mode[0])
      b = get(ints, ip+2, mode[1])
      value = a == b ? 1 : 0
      set(ints, ip+3, mode[2], value)
      ip += 4
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
  5
end

def output(value)
  puts "Output: #{value}"
end

run_intcode "3,9,8,9,10,9,4,9,99,-1,8"
run_intcode "3,3,1108,-1,8,3,4,3,99"
run_intcode "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"

run_intcode input

# >> Output: 0
# >> Complete: 3
# >> Output: 0
# >> Complete: 3
# >> Output: 999
# >> Complete: 3
# >> Output: 12410607
# >> Complete: 314

