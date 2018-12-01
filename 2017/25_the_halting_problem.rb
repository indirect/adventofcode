input = DATA.read.chomp.split("\n\n")

testcase = <<-END.chomp.split("\n\n")
Begin in state A.
Perform a diagnostic checksum after 6 steps.

In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state B.

In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A.
END

def execute(input)
  rules = input[1..-1].map do |text|
    r = text.scan(/In state (.):
  If the current value is (\d):
    - Write the value (\d)\.
    - Move one slot to the (left|right)\.
    - Continue with state (.)\.
  If the current value is (\d):
    - Write the value (\d)\.
    - Move one slot to the (left|right)\.
    - Continue with state (.)\./).first
    [r[0], {
      r[1].to_i => [r[2].to_i, r[3], r[4]],
      r[5].to_i => [r[6].to_i, r[7], r[8]],
    }]
  end.to_h

  state  = input[0].match(/^Begin in state (.)/)[1]
  steps  = input[0].match(/ (\d*) steps\.$/)[1].to_i
  tape   = [0]
  cursor = 0

  # puts tape.dup.map{|i| " #{i} "}.tap{|t| t[cursor] = "[#{t[cursor].to_i}]" }.join +
  #   "  step 0; about to run state #{state}"
  # puts

  1.upto(steps) do |step|
    rule  = rules[state]
    value = tape[cursor]
    actions = rule[value]
    tape[cursor] = actions[0]

    if actions[1] == "left"
      if cursor.zero?
        tape.unshift(0)
      else
        cursor -= 1
      end
    else
      cursor += 1
      tape.push(0) if tape[cursor].nil?
    end

    state = actions[2]
    # puts tape.dup.map{|i| " #{i} "}.tap{|t| t[cursor] = "[#{t[cursor].to_i}]" }.join +
    #   " step #{step} => #{state}"
    # puts
  end

  tape
end

puts "part 1"
raise "oh no" unless execute(testcase).count(1) == 3
p execute(input).count(1)

__END__
Begin in state A.
Perform a diagnostic checksum after 12683008 steps.

In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state B.

In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state C.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state E.

In state C:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state E.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state D.

In state D:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.

In state E:
  If the current value is 0:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state A.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state F.

In state F:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state E.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A.
