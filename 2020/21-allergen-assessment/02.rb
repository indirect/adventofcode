def solve(solution)
  reduced = solution.map do |a, fs|
    [a, fs.inject(:&)]
  end.to_h

  until reduced.all?{|k,v| v.size == 1 }
    reduced.select{|k,v| v.size == 1 }.each do |kak, kav|
      reduced.each do |k, v|
        next if k == kak
        reduced[k] = v - kav
      end
    end
  end

  reduced
end

def part1(lines)
  allergen_list = Hash.new {|k,v| k[v] = Array.new }

  recipes = lines.map{|l| l.split(" (contains ").map{|s| s.split(" ").map{|n| n.chomp(")").chomp(",") } } }

  recipes.each do |(foods, allergens)|
    allergens.each do |a|
      allergen_list[a].push(foods)
    end
  end

  solution = solve(allergen_list.dup)

  solution.sort_by{|k,v| k }.map(&:last).join(",")
end

p part1(File.read("sample.txt").split("\n"))
p part1(File.read("input.txt").split("\n"))
