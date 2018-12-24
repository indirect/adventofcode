#!/usr/bin/ruby

input = 540561

class Scoreboard
  attr_reader :recipes, :elves

  def initialize(debug = false)
    @recipes = [3, 7]
    @elves = [0, 1]
    @debug = debug
    @step = 0
    puts inspect if @debug
  end

  def until_sequence(n)
    catch :done do
      loop do
        new_recipes = elves.map{|i| recipes[i] }.inject(0, :+).to_s.chars.map(&:to_i)
        new_recipes.each do |r|
          recipes.push r
          throw :done if recipes.size >= n.size && recipes[-n.size..-1].join == n
        end
        elves.map!{|e| (e + 1 + recipes[e]) % recipes.size }
        @step += 1
      end
    end

    recipes.size - n.size
  end

  def inspect
    recipes.map{|r| " #{r} " }.tap do |rs|
      rs[elves[0]].gsub!(/ (.) /, '(\1)')
      rs[elves[1]].gsub!(/ (.) /, '[\1]')
    end.join
  end
end

puts Scoreboard.new.until_sequence "51589"
puts Scoreboard.new.until_sequence "01245"
puts Scoreboard.new.until_sequence "92510"
puts Scoreboard.new.until_sequence "59414"
puts Scoreboard.new.until_sequence input.to_s
