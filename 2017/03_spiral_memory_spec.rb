require "./03_spiral_memory"

distances = {
  1 => 0,
  12 => 3,
  23 => 2,
  1024 => 31,
  325489 => 552,
}

sums = {
  1 => 1,
  2 => 1,
  3 => 2,
  4 => 4,
  5 => 5,
  9 => 25,
  23 => 806,
}

RSpec.describe "spiral memory" do

  describe "distances" do
    distances.each do |index, distance|
      it "knows the distance of entry #{index} is #{distance}" do
        expect(SpiralMemory.distance(index)).to eq(distance)
      end
    end
  end

  describe "sum values" do
    sums.each do |index, sum|
      it "knows the value of entry #{index} is #{sum}" do
        expect(SpiralMemory.sum(index)).to eq(sum)
      end
    end
  end

end
