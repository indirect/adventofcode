Layer = Struct.new(:depth, :sentry, :direction)
class Firewall
  attr_reader :layers

  def initialize(input, debug = false)
    @debug = debug
    @layers = []
    input.map{|i| i.split(":").map(&:to_i) }.each do |i,d|
      @layers[i] = Layer.new(d, 0, 1)
    end
    @packet = 0
    @severity = 0
  end

  def step
    puts inspect if @debug

    l = @layers[@packet]
    if l && l.sentry.zero?
      @severity += l.depth * @packet
    end

    @layers.each do |l|
      next if l.nil?
      l.sentry += l.direction
      l.direction *= -1 if l.sentry.zero? || l.sentry == (l.depth - 1)
    end

    @packet += 1
  end

  def severity
    step until @packet == @layers.size
    @severity
  end

  def inspect
    map = [
      "Picosecond #{@packet}:",
      (0...@layers.size).map{|i| " #{i} " }.join(" ")
    ]

    @layers.compact.max_by(&:depth).depth.times do |i|
      map << @layers.map.with_index do |l, idx|
        if l && l.depth > i
          str = (@packet == idx && i.zero?) ? "( )" : "[ ]"
          l.sentry == i ? str.gsub(" ", "S") : str
        else
          if @packet == idx && i.zero?
            "(.)"
          else
            i.zero? ? "..." : "   "
          end
        end
      end.join(" ")
    end

    map.join("\n") + "\n"
  end
end

if $0 == __FILE__
  input = parse(DATA.read)
  testcase = parse("0: 3\n1: 2\n4: 4\n6: 4")

  p Firewall.new(testcase, :debug).severity
end

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
