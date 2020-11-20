# frozen_string_literal: true

require 'benchmark/memory/helpers'

module Benchmark
  module Memory
    class Measurement
      # Describe the ratio of allocated vs. retained memory in a measurement.
      class Metric
        include Comparable

        # Instantiate a Metric of allocated vs. retained memory.
        #
        # @param type [Symbol] The type of memory allocated in the metric.
        # @param allocated [Integer] The amount allocated in the metric.
        # @param retained [Integer] The amount retained in the metric.
        def initialize(type, allocated, retained)
          @type = type
          @allocated = allocated
          @retained = retained
        end

        # @return [Integer] The amount allocated in the metric.
        attr_reader :allocated

        # @return [Integer] The amount retained in the metric.
        attr_reader :retained

        # @return [Symbol] The type of memory allocated in the metric.
        attr_reader :type

        # Sort by the total allocated.
        #
        # @param other [Metric] The other metric.
        #
        # @return [Integer]
        def <=>(other)
          allocated <=> other.allocated
        end
      end
    end
  end
end
