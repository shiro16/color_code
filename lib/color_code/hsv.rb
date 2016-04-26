module ColorCode
  class HSV
    attr_accessor :h, :s, :v

    def initialize(code=nil, h: 0, s: 0, v: 0)
      if code
        hsv = ColorCode::RGB.new(code).to_hsv
        h, s, v = hsv.to_a
      end

      @h = h
      @s = s
      @v = v
      raise if @h > 360 || @s > 100 || @v > 100
    rescue
      raise ArgumentError.new('invalid value')
    end

    def to_s
      rgb = convert_rgb.map { |hue| '%02x' % hue }.join
      "##{rgb}"
    end

    def to_a
      [@h, @s, @v]
    end

    def to_hash
      { h: @h, s: @s, v: @v }
    end

    def to_rgb
      r, g, b = convert_rgb
      ColorCode::RGB.new(r: r, g: g, b: b)
    end

    private
    def convert_rgb
      max = @v * 255 / 100.to_f
      min = (@s / 100.to_f * max - max) * -1

      case @h
      when 0...60
        r = max
        g = (@h.quo(60).to_f) * (max - min) + min
        b = min
      when 60...120
        r = ((120 - @h).quo(60).to_f) * (max - min) + min
        g = max
        b = min
      when 120...180
        r = min
        g = max
        b = ((@h - 120).quo(60).to_f) * (max - min) + min
      when 180...240
        r = min
        g = ((240 - @h).quo(60).to_f) * (max - min) + min
        b = max
      when 240...300
        r = ((@h - 240).quo(60).to_f) * (max - min) + min
        g = min
        b = max
      when 300..360
        r = max
        g = min
        b = ((360 - @h).quo(60).to_f) * (max - min) + min
      end
      [r.round, g.round, b.round]
    end
  end
end
