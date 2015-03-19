module ColorCode
  class RGB
    attr_accessor :r, :g, :b
    
    def initialize(code=nil, r: 0, g: 0, b: 0)
      r, g, b = parse_code(code) if code
      @r = r
      @g = g
      @b = b
    end

    def to_s
      rgb = [@r, @g, @b].map { |hue| '%02x' % hue }.join
      "##{rgb}"
    end

    def to_hash
      { r: @r, g: @g, b: @b }
    end

    private
    def parse_code(code)
      [0, 0, 0] unless md = code.match(/^#([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})$/)
      md[1..3].map(&:hex)
    end
  end
end
