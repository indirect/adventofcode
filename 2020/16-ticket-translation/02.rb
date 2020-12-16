def error_rate(input)
  fields, ticket, nearby = input.split("\n\n")

  fields = fields.split("\n").map do |l|
    k,v = l.split(": ")
    [k, v.split(" or ").map{|rs| Range.new(*rs.split("-").map(&:to_i)) }]
  end.to_h

  ticket = ticket.split("\n").last.split(",").map(&:to_i)
  nearby = nearby.split("\n")[1..-1].map{|t| t.split(",").map(&:to_i) }

  valid = nearby.select do |t|
    t.all? do |tv|
      fields.values.flatten.any?{|v| v.include?(tv) }
    end
  end

  field_candidates = fields.map do |name, ranges|
    col = (0...valid.size).select do |i|
      valid.all? do |v|
        ranges.any?{|r| r.include?(v[i]) }
      end
    end
    [name, col]
  end.sort_by{|k,v| v.size }.to_h

  field_numbers = {}
  field_candidates.each do |name, options|
    col = (options - field_numbers.values).first
    field_numbers[name] = col
  end

  fields.keys.grep(/^departure/).map{|k| ticket[field_numbers[k]] }.inject(:*)

end

# p error_rate(DATA.read)
p error_rate(File.read("input.txt"))

__END__
class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9
