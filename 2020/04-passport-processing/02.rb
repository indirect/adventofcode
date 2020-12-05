def valid_passports(filename)
  data = File.read(filename+".txt")

  passports = data.split("\n\n").map do |passport|
    passport.gsub("\n", " ").split(" ").map do |field|
      field.split(":")
    end.to_h
  end

  valid = passports.select do |fields|
    required = %w[byr iyr eyr hgt hcl ecl pid]
    required.all? do |key|
      fields.has_key?(key) && valid_field(key, fields[key])
    end
  end

  pp valid.map{|v| v["pid"] }.uniq.sort_by(&:to_i)

  valid.count
end

def valid_field(key, value)
  case key
  when "byr"
    valid_year(value, min: 1920, max: 2002)
  when "iyr"
    valid_year(value, min: 2010, max: 2020)
  when "eyr"
    valid_year(value, min: 2020, max: 2030)
  when "hgt"
    ivalue = value[0..-3].to_i
    if value[-2..-1] == "cm"
      150 <= ivalue && ivalue <= 193
    elsif value [-2..-1] == "in"
      59 <= ivalue && ivalue <= 76
    else
      false
    end
  when "hcl"
    !!value.match(/#[0-9a-f]{6}/)
  when "ecl"
    %w[amb blu brn gry grn hzl oth].include?(value)
  when "pid"
    !!value.match(/^\d{9}$/)
  end
end

def valid_year(value, min:, max:)
  ivalue = value.to_i
  svalue = value.to_s
  svalue.length == 4 && min <= ivalue && ivalue <= max
end
# p valid_field("hgt", "150cm")

# p valid_field("byr", "2002")
# p valid_field("byr", "2003")

# p valid_field("hgt", "60in")
# p valid_field("hgt", "190cm")
# p valid_field("hgt", "190in")
# p valid_field("hgt", "190")

# p valid_field("hcl", "#123abc")
# p valid_field("hcl", "#123abz")
# p valid_field("hcl", "123abc")

# p valid_field("ecl", "brn")
# p valid_field("ecl", "wat")

# p valid_field("pid", "000000001")
# p valid_field("pid", "0123456789")

p valid_passports("sample")

p valid_passports("invalid")
p valid_passports("valid")

p valid_passports("input")
