def parse(input)
  input.chomp.split("\n").map{|i| i.split(": ").map(&:to_i) }
end

def severity(layers, delay = 0)
  layers.map do |i, d|
    i += delay
    interval = 2 + (d-2) * 2
    (i % interval).zero? ? i * d : 0
  end.sum
end

def safe_delay(layers)
  delay = 0
  delay += 1 until severity(layers, delay).zero?
  delay
end

input = parse(DATA.read)
testcase = parse("0: 3\n1: 2\n4: 4\n6: 4")

puts "part 1"
raise "oh no" unless severity(testcase) == 24
p severity(input)

puts "part 2"
raise "oh no" unless safe_delay(testcase) == 10
p safe_delay(input)

__END__
0: 3
1: 2
2: 9
4: 4
6: 4
8: 6
10: 6
12: 8
14: 5
16: 6
18: 8
20: 8
22: 8
24: 6
26: 12
28: 12
30: 8
32: 10
34: 12
36: 12
38: 10
40: 12
42: 12
44: 12
46: 12
48: 14
50: 14
52: 8
54: 12
56: 14
58: 14
60: 14
64: 14
66: 14
68: 14
70: 14
72: 14
74: 12
76: 18
78: 14
80: 14
86: 18
88: 18
94: 20
98: 18
