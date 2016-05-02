module ColorCode
  class HSL
    include HueSaturation

    attr_accessor :h, :s, :l

    def initialize(code=nil, h: 0, s: 0, l: 0)
      if code
        hsl = ColorCode::RGB.new(code).to_hsl
        h, s, l = hsl.to_a
      end

      @h = h
      @s = s
      @l = l
      raise if @h > 360 || @s > 100 || @l > 100
    rescue
      raise ArgumentError.new('invalid value')
    end

    def to_a
      [@h, @s, @l]
    end

    def to_hash
      { h: @h, s: @s, l: @l }
    end

    private
    def convert_max
      if @l < 50
        2.55 * (@l + @l * @s.quo(100).to_f)
      else
        2.55 * (@l + (100 - @l) * @s.quo(100).to_f)
      end
    end

    def convert_min
      if @l < 50
        2.55 * (@l - @l * @s.quo(100).to_f)
      else
        2.55 * (@l - (100 - @l) * @s.quo(100).to_f)
      end
    end
  end
end
