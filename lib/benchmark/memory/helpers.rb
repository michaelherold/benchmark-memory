module Benchmark
  module Memory
    module Helpers
      # Scale a value into human-understandable terms.
      #
      # @param value [Integer, Float] The value to scale.
      #
      # @return [String] The scaled value.
      def scale(value)
        scale = Math.log10(value)
        scale = 0 if scale.infinite?
        scale = (scale / 3).to_i
        suffix =
          case scale
          when 1 then "k"
          when 2 then "M"
          when 3 then "B"
          when 4 then "T"
          when 5 then "Q"
          else
            scale = 0
            " "
          end

        format("%10.3f#{suffix}", value.to_f / (1000**scale))
      end
      module_function :scale
    end
  end
end
