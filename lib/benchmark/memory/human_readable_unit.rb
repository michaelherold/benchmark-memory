module Benchmark
  module Memory
    # Transforms raw numbers into a human-readable scale and suffix
    class HumanReadableUnit < SimpleDelegator
      # Instantiates a HumanReadableUnit from a numeric value
      #
      # @param value [Numeric] the value make human-readable
      def initialize(value)
        super(value)
      end

      # @return [Integer] the exponential scale of the value
      def scale
        scale = Math.log10(__getobj__)
        scale = 0 if scale.infinite?
        scale = (scale / 3).to_i

        if scale <= 5
          scale
        else
          0
        end
      end

      # @return [String] the single-character unit for the value
      def unit
        case scale
        when 1 then 'k'
        when 2 then 'M'
        when 3 then 'B'
        when 4 then 'T'
        when 5 then 'Q'
        else ' '
        end
      end
    end
  end
end
