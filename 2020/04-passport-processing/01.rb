def valid_passports(filename)
  data = File.read(filename+".txt")

  data.split("\n\n").select do |passport|
    fields = passport.gsub("\n", " ").split(" ").map do |field|
      field.split(":")
    end.to_h

    required = %w[byr iyr eyr hgt hcl ecl pid]
    required.all?{|key| fields.has_key?(key) }
  end.count
end

p valid_passports("sample")

p valid_passports("input")
