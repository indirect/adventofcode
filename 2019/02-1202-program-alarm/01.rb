input = File.read("input.txt").chomp.split(",").map(&:to_i)

def run_intcode(ints)
  ip = 0

  until 99 == ints[ip]
    case ints[ip]
    when 1
      a = ints[ip+1]
      b = ints[ip+2]
      d = ints[ip+3]
      ints[d] = ints[a] + ints[b]
    when 2
      a = ints[ip+1]
      b = ints[ip+2]
      d = ints[ip+3]
      ints[d] = ints[a] * ints[b]
    else
      return
    end

    ip += 4
  end

  ints
end

run_intcode "1,9,10,3,2,3,11,0,99,30,40,50".split(",").map(&:to_i)
run_intcode "1,0,0,0,99".split(",").map(&:to_i)
run_intcode "2,3,0,3,99".split(",").map(&:to_i)
run_intcode "2,4,4,5,99,0".split(",").map(&:to_i)
run_intcode "1,0,0,0,99".split(",").map(&:to_i)
run_intcode "1,1,1,4,99,5,6,0,99".split(",").map(&:to_i)

# part 1
part1 = input.dup
part1[1] = 12
part1[2] = 2

p run_intcode(part1)


# part 2

def find_values(memory)
  (0..99).each do |noun|
    (0..99).each do |verb|
      trial = memory.dup
      trial[1] = noun
      trial[2] = verb
      run_intcode(trial)
      return (100 * noun) + verb if trial[0] == 19690720
    end
  end
end

p find_values(input)
