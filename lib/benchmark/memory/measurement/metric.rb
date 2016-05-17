require "benchmark/memory/helpers"

module Benchmark
  module Memory
    class Measurement
      # Describe the ratio of allocated vs. retained memory in a measurement.
      class Metric
        include Helpers

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

        # Format the metric for output to an IO.
        #
        # @return [String] The formatted metric for output.
        def to_s
          [allocated_str, retained_str].join(" - ")
        end

        private

        def allocated_str
          format("%s %s", scale(allocated), type)
        end

        def retained_str
          format("(%s retained)", scale(retained))
        end
      end
    end
  end
end
