module ColorCode
  class HSL
    attr_accessor :h, :s, :l

    def initialize(h: 0, s: 0, l: 0)
      @h = h
      @s = s
      @l = l
    end

    def to_hash
      { h: @h, s: @s, l: @l }
    end
  end
end
