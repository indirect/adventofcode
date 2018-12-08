#!/usr/bin/ruby

input = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2".split(" ").map(&:to_i)
input = File.read("input.txt").split(" ").map(&:to_i)

def parse_node(node)
  return [nil, []] if node.empty?
  
  child_count = node.shift
  meta_count = node.shift

  children = []
  child_count.times do
    child, node = parse_node(node)
    children << child if child
  end
  metadata = meta_count.times.map{ node.shift }

  [{children: children, metadata: metadata}, node]
end

root, _ = parse_node(input)

def sum_metadata(node)
  sum = node[:metadata].sum

  children = node[:children].map do |c|
    sum_metadata(c)
  end
  
  sum + children.inject(0, &:+)
end

p sum_metadata(root)