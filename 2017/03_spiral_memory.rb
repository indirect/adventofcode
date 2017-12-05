class SpiralMemory
  def self.distance(index = nil)
    index ? new.entry(index).distance : new
  end

  def self.sum(index = nil)
    sm = new do |x, y, sm|
      surrounds = [0, 1, 1, -1, -1].permutation(2).uniq
      surrounds.map{|ox, oy| sm[x+ox, y+oy] }.sum
    end

    index ? sm.entry(index).value : sm
  end

  Location = Struct.new(:x, :y, :value) do
    def distance
      x.abs + y.abs
    end
  end

  attr_reader :content, :value_proc, :default_value
  attr_accessor :max, :state

  def initialize(default_value = 0, &block)
    @content = [Location.new(0, 0, 1)]
    @max = 1
    @state = 1
    @value_proc = block
    @default_value = default_value
  end

  def[](x, y)
    loc = content.reverse.find do |loc|
      loc.x == x && loc.y == y
    end

    loc ? loc.value : default_value
  end

  def entry(index)
    grow until content.size == index
    content.last
  end

  def grow
    loc = content.last.dup

    case self.state
    when 1
      loc.y += 1
      self.state += 1 if loc.y == self.max
    when 2
      loc.x -= 1
      self.state += 1 if loc.x == -self.max
    when 3
      loc.y -= 1
      self.state += 1 if loc.y == -self.max
    when 4
      loc.x += 1
      self.state += 1 if loc.x == self.max
    when 5
      loc.y += 1

      if loc.y.zero?
        self.max += 1
        self.state = 1
      end
    end

    if @value_proc
      loc.value = @value_proc.call(loc.x, loc.y, self)
    else
      loc.value += 1
    end

    content.push loc
  end
end
