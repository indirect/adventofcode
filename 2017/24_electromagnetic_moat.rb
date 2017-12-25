input = DATA.read.chomp.split("\n")
testcase = "0/2\n2/2\n2/3\n3/4\n3/5\n0/1\n10/1\n9/10".split("\n")

def strongest(input)
  components = input.map{|c| c.split("/").map(&:to_i) }
  bridges = components.select{|l,r| l.zero? || r.zero? }.map{|c| [c.sort] }

  bridges.each do |bridge|
    if bridge.length > 1 && bridge[-1][0] != bridge[-1][1]
      edge = bridge[-1].find{|x| !bridge[-2].include?(x) }
    else
      edge = bridge[-1].find{|x| !x.zero? }
    end

    remaining = components - bridge
    remaining.select{|l,r| l == edge || r == edge }.each do |c|
      bridges.push(bridge + [c])
    end
  end

  b = bridges.max_by{|b| b.flatten.sum }
  b.map{|c| c.join("/") }.join("--") + " = #{b.flatten.sum}"
end

puts "part 1"
raise "oh no" unless strongest(testcase) == "0/1--10/1--9/10 = 31"
p strongest(input)

def longest(input)
  components = input.map{|c| c.split("/").map(&:to_i) }
  bridges = components.select{|l,r| l.zero? || r.zero? }.map{|c| [c.sort] }

  bridges.each do |bridge|
    if bridge.length > 1 && bridge[-1][0] != bridge[-1][1]
      edge = bridge[-1].find{|x| !bridge[-2].include?(x) }
    else
      edge = bridge[-1].find{|x| !x.zero? }
    end

    remaining = components - bridge
    remaining.select{|l,r| l == edge || r == edge }.each do |c|
      bridges.push(bridge + [c])
    end
  end

  max_length = bridges.map(&:length).max
  b = bridges.select{|b| b.length == max_length }.max_by{|b| b.flatten.sum }
  b.map{|c| c.join("/") }.join("--") + " = #{b.flatten.sum}"
end

puts "part 2"
raise "oh no" unless longest(testcase) == "0/2--2/2--2/3--3/5 = 19"
p longest(input)

__END__
50/41
19/43
17/50
32/32
22/44
9/39
49/49
50/39
49/10
37/28
33/44
14/14
14/40
8/40
10/25
38/26
23/6
4/16
49/25
6/39
0/50
19/36
37/37
42/26
17/0
24/4
0/36
6/9
41/3
13/3
49/21
19/34
16/46
22/33
11/6
22/26
16/40
27/21
31/46
13/2
24/7
37/45
49/2
32/11
3/10
32/49
36/21
47/47
43/43
27/19
14/22
13/43
29/0
33/36
2/6
