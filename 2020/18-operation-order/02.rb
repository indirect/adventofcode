def parse(line)
  # only works with single character numbers
  line.split(" ").flat_map(&:chars)
end

def e(tokens)
  i = 0
  while tokens.include?("(")
    if tokens[i] == "("
      subtokens = [tokens.delete_at(i)]
      subtokens << tokens.delete_at(i) until subtokens.count("(") == subtokens.count(")")
      tokens.insert i, *e(subtokens[1...-1])
    end
    i += 1
  end

  tokens = sube(tokens, "+")
  tokens = sube(tokens, "*")

  tokens
end

def sube(tokens, target)
  while tokens.include?(target)
    i = 0

    until i + 2 > tokens.size
      if tokens[i+1] == target
        left = tokens.delete_at(i)
        op = tokens.delete_at(i)
        right = tokens.delete_at(i)
        tokens.insert(i, eval("#{left} #{op} #{right}"))
      end
      i += 2
    end
  end

  tokens
end

def sum(input)
  input.map { |line| e parse(line) }.flatten.sum
end

p sum(["1 + (2 * 3) + (4 * (5 + 6))"])
p sum(["2 * 3 + (4 * 5)"])
p sum(File.read("input.txt").split("\n"))

