def shiny_gold_bag_contains(filename)
  data = File.read(filename+".txt").split("\n")

  bag_map = data.map do |d|
    color,content = d.split(" bags contain ")
    content = content.split(", ").map do |c|
      count, shade, name = c.split(" ")
      {count: count.to_i, color: "#{shade} #{name}"} unless count == "no"
    end.compact
    {color: color, content: content}
  end

  all_bags = []
  new_bags = bags_inside("shiny gold", bag_map)
  until new_bags.empty?
    all_bags.push(*new_bags)
    new_bags = new_bags.flat_map do |b|
      b[:count].times.flat_map do
        bags_inside(b[:color], bag_map)
      end
    end
  end

  all_bags.map{|b| b[:count] }.sum
end

def bags_inside(color, bag_map)
  bag_map.find{|bag| bag[:color] == color }[:content]
end

p shiny_gold_bag_contains("sample")
p shiny_gold_bag_contains("input")
