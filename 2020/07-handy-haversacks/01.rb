def shiny_gold_bags(filename)
  data = File.read(filename+".txt").split("\n")

  bag_map = data.map do |d|
    color,content = d.split(" bags contain ")
    content = content.split(", ")
    {color: color, content: content}
  end

  found_bags = []
  containing_bags = can_contain?("shiny gold", bag_map)
  until containing_bags.empty?
    found_bags.push(*containing_bags)
    containing_bags = containing_bags.flat_map do |bag|
      can_contain?(bag[:color], bag_map)
    end
  end

  found_bags.map{|b| b[:color] }.uniq
end

def can_contain?(color, bag_map)
  bag_map.select do |bag|
    bag[:content].any?{|c| c.include?(color) }
  end
end

p shiny_gold_bags("sample").count
p shiny_gold_bags("input").count
