#!/usr/bin/ruby

input = 540561

class Scoreboard
  attr_reader :recipes, :elves

  def initialize(recipes = [3, 7], debug = false)
    @recipes = recipes
    @elves = [0, 1]
    @debug = debug
    puts inspect if @debug
  end

  def step
    new_recipes = elves.map{|i| recipes[i] }.sum.to_s.chars.map(&:to_i)
    recipes.push *new_recipes
    elves.map!{|e| (e + 1 + recipes[e]) % recipes.size }
    puts inspect if @debug
  end

  def after_recipe(n)
    step until recipes.size >= (n + 10)
    recipes[-10..-1].join
  end

  def inspect
    recipes.map{|r| " #{r} " }.tap do |rs|
      rs[elves[0]].gsub!(/ (.) /, '(\1)')
      rs[elves[1]].gsub!(/ (.) /, '[\1]')
    end.join
  end
end

s = Scoreboard.new([3,7])
puts s.after_recipe(9)
puts s.after_recipe 5
puts s.after_recipe 18
puts s.after_recipe 2018
puts
puts s.after_recipe(input)
