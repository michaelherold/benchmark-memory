# frozen_string_literal: true

require 'benchmark/memory/human_readable_unit'

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
        value = HumanReadableUnit.new(value)

        format("%10.3f#{value.unit}", value.to_f / (1000**value.scale))
      end

      module_function :scale
    end
  end
end
