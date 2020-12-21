def e(tokens)
  current = nil
  op = nil

  until tokens.empty?
    if tokens[0] == "("
      subtokens = [tokens.shift]
      subtokens << tokens.shift until subtokens.count(")") == subtokens.count("(")
      upcoming = e(subtokens[1..-1])
    else
      upcoming = tokens.shift
    end

    case upcoming
    when " "
      next
    when /\d/
      number = [upcoming]
      number << tokens.shift until tokens.empty? || number.last == " "
      upcoming = number.join.chomp(" ").to_i
    when "+"
      op = "+"
      next
    when "*"
      op = "*"
      next
    end

    if current.nil?
      current = upcoming
    else
      p [current, op, upcoming]
      case op
      when "+"
        current += upcoming
        op = nil
      when "*"
        current *= upcoming
        op = nil
      end
    end
  end

  current
end

end
  input.map do |line|
    e(line.chars)
  end
def sum(input)
  input.map { |line| e parse(line) }
# p sum ["2 * 3"]
# p sum(["1 + 2 * 3 + 4 * 5 + 6"])
# p sum(["((2 * 3)) + (4 * 5)"])
p sum(File.read("input.txt").split("\n"))
p sum(["((2 * 3)) + (4 * 5)"])
# p sum(File.read("input.txt").split("\n"))
