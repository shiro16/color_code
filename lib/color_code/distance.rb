module ColorCode
  class Distance
    class << self
      def results(color)
        config.colors.inject({}) do |sum, base|
          sum[base[:id]] = color.distance(base[:color])
          sum
        end.sort { |a, b| a[1] <=> b[1] }
      end

      def min(color)
        results(color).first
      end

      def max(color)
        results(color).last
      end

      def configure
        yield config
      end

      private
      def config
        @config ||= Config.new
      end
    end

    class Config
      attr_accessor :colors

      def initialize
        @colors = []
      end
    end
  end
end
