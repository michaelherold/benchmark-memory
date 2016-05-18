module Benchmark
  module Memory
    # Helper methods for formatting output.
    module Helpers
      # Right-justifies to a length of 20 or adds a line of padding when longer.
      #
      # @param label [#to_s] The label to justify.
      #
      # @return [String] The justified label.
      def rjust(label)
        label = label.to_s

        if label.size > 20
          "#{label}\n#{' ' * 20}"
        else
          label.rjust(20)
        end
      end

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
