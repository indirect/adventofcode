input = File.read("input.txt")
sample = File.read("sample.txt")

def increased(input)
  input = input.split("\n").map(&:to_i)
  count = 0
  puts "#{input.first} (N/A)"
  input.each_cons(3).map{|x| x.sum }.each_cons(2) do |a,b|
    count += 1 if b > a
    puts "#{b} (#{b > a ? bold('+') : '-'}) #{count}"
  end
  p count
end

TWHITE = `tput setaf 7`.chomp
TBOLD = `tput bold`.chomp
TRESET = `tput sgr0`.chomp
def bold(text)
  "#{TWHITE}#{TBOLD}#{text}#{TRESET}"
end

increased(input)
increased(sample)
