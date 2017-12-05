require "./05_a_maze_of_twisty_trampolines_all_alike.rb"

RSpec.describe "the given small test case" do
  let(:input) { [0, 3, 0, 1, -3] }

  it "takes five steps in part one" do
    expect(part_one(input)).to eq(5)
  end

  it "takes ten steps in part two" do
    expect(part_two(input)).to eq(10)
  end
end
