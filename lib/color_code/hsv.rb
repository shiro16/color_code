module ColorCode
  class HSV
    include HueSaturation

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

    def to_a
      [@h, @s, @v]
    end

    def to_hash
      { h: @h, s: @s, v: @v }
    end

    def distance(hsv)
      diff = if @h > hsv.h
               [@h - hsv.h, hsv.h - @h + 360].min
             else
               [hsv.h - @h, @h - hsv.h + 360].min
             end
      Math.sqrt(diff**2 + (@s - hsv.s)**2 + (@v - hsv.v)**2)
    end

    private
    def convert_max
      @v * 255 / 100.to_f
    end

    def convert_min
      (@s / 100.to_f * convert_max - convert_max) * -1
    end
  end
end
