module ColorCode
  class HSL
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

    def to_s
      rgb = convert_rgb.map { |hue| '%02x' % hue }.join
      "##{rgb}"
    end

    def to_a
      [@h, @s, @l]
    end

    def to_hash
      { h: @h, s: @s, l: @l }
    end

    def to_rgb
      r, g, b = convert_rgb
      ColorCode::RGB.new(r: r, g: g, b: b)
    end

    private
    def convert_rgb
      if @l < 50
        max = 2.55 * (@l + @l * @s.quo(100).to_f)
        min = 2.55 * (@l - @l * @s.quo(100).to_f)
      else
        max = 2.55 * (@l + (100 - @l) * @s.quo(100).to_f)
        min = 2.55 * (@l - (100 - @l) * @s.quo(100).to_f)
      end

      case @h
      when 0...60
        r = max
        g = (@h / 60) * (max - min) + min
        b = min
      when 60...120
        r = ((120 - @h) / 60) * (max - min) + min
        g = max
        b = min
      when 120...180
        r = min
        g = max
        b = ((@h - 120) / 60) * (max - min) + min
      when 180...240
        r = min
        g = ((240 - @h) / 60) * (max - min) + min
        b = max
      when 240...300
        r = ((@h - 240) / 60) * (max - min) + min
        g = min
        b = max
      when 300..360
        r = max
        g = min
        b = ((360 - @h) / 60) * (max - min) + min
      end
      [r.round, g.round, b.round]
    end
  end
end
