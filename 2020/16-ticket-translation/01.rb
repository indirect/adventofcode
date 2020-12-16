def error_rate(input)
  fields, ticket, nearby = input.split("\n\n")

  fields = fields.split("\n").map do |l|
    k,v = l.split(": ")
    [k, v.split(" or ").map{|rs| Range.new(*rs.split("-").map(&:to_i)) }]
  end.to_h

  ticket = ticket.split("\n").last.split(",").map(&:to_i)
  nearby = nearby.split("\n")[1..-1].map{|t| t.split(",").map(&:to_i) }

  invalid = []
  nearby.select do |t|
    t.all? do |tv|
      valid = fields.values.flatten.any?{|v| v.include?(tv) }
      invalid.push(tv) unless valid
      valid
    end
  end

  invalid.sum
end

p error_rate(DATA.read)
p error_rate(File.read("input.txt"))

__END__
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
