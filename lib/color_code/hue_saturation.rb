module ColorCode
  module HueSaturation
    def to_s
      rgb = convert_rgb.map { |hue| '%02x' % hue }.join
      "##{rgb}"
    end

    def to_rgb
      r, g, b = convert_rgb
      ColorCode::RGB.new(r: r, g: g, b: b)
    end

    private
    def convert_rgb
      max = convert_max
      min = convert_min

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
