class KnotHash
  def self.round(lengths, size = 255)
    list = (0..size).to_a
    pos = 0
    skip = 0

    lengths.each do |l|
      sel = l.times.map{|i| list[(pos+i)%list.size] }.reverse
      l.times{|i| list[(pos+i)%list.size] = sel[i] }
      pos += l + skip
      skip += 1
    end

    list[0] * list[1]
  end

  def self.hash(input)
    lengths = input.chars.map(&:ord) + [17, 31, 73, 47, 23]

    list = (0..255).to_a
    pos = 0
    skip = 0

    64.times do
      lengths.each do |l|
        sel = l.times.map{|i| list[(pos+i)%list.size] }.reverse
        l.times{|i| list[(pos+i)%list.size] = sel[i] }
        pos += l + skip
        skip += 1
      end
    end

    list.each_slice(16).map{|slice| "%02x" % slice.inject(&:^) }.join.downcase
  end
end

if $0 == __FILE__
  input = "183,0,31,146,254,240,223,150,2,206,161,1,255,232,199,88"

  puts "part 1"
  raise "oh no" unless KnotHash.round([3,4,1,5], 4) == 12
  p KnotHash.round(input.split(",").map(&:to_i))

  puts "part 2"
  testcase = "1,2,4"
  raise "oh no: #{KnotHash.hash(testcase)}" unless KnotHash.hash(testcase) == "63960835bcdc130f0b66d7ff4f6a5a8e"
  puts KnotHash.hash(input)
end
