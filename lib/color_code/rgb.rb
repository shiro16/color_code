module ColorCode
  class RGB
    attr_accessor :r, :g, :b

    def initialize(code=nil, r: 0, g: 0, b: 0)
      r, g, b = parse_code(code) if code
      @r = r
      @g = g
      @b = b
      raise ArgumentError.new('invalid value') if @r > 255 || @g > 255 || @b > 255
    end

    def to_s
      rgb = to_a.map { |hue| '%02x' % hue }.join
      "##{rgb}"
    end

    def to_a
      [@r, @g, @b]
    end

    def to_hash
      { r: @r, g: @g, b: @b }
    end

    def to_hsl
      ColorCode::HSL.new(h: h, s:hsl_s, l:l)
    end

    def to_hsv
      ColorCode::HSV.new(h: h, s:hsv_s, v:v)
    end

    private
    def parse_code(code)
      raise ArgumentError.new('invalid value') unless md = code.match(/^#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})$/)
      md[1..3].map(&:hex)
    end

    def h
      return 0 if max == min
      hue = case max
            when @r
              60 * ((@g - @b).quo(max - min).to_f)
            when @g
              60 * ((@b - @r).quo(max - min).to_f) + 120
            when @b
              60 * ((@r - @g).quo(max - min).to_f) + 240
            end
      hue += 360 if hue < 0
      hue.round
    end

    def hsl_s
      return 0 if max == min
      converge = (max + min) / 2

      saturation = if converge < 128
                     (max - min).quo(max + min).to_f
                   else
                     (max - min).quo(510 - max - min).to_f
                   end
      (saturation * 100).round
    end

    def hsv_s
      if max.zero?
        0
      else
        (max - min) / max.to_f * 100
      end
    end

    def l
      luminance = (max + min).quo(2).to_f
      luminance = luminance.quo(255).to_f * 100
      luminance.round
    end

    def v
      (max.quo(255).to_f * 100).round
    end

    def max
      to_a.max
    end

    def min
      to_a.min
    end
  end
end
