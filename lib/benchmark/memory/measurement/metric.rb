module Benchmark
  module Memory
    class Measurement
      # Describe the ratio of allocated vs. retained memory in a measurement.
      class Metric
        # Instantiate a Metric of allocated vs. retained memory.
        #
        # @param allocated [Integer] The amount allocated in the metric.
        # @param retained [Integer] The amount retained in the metric.
        def initialize(allocated, retained)
          @allocated = allocated
          @retained = retained
        end

        # @return [Integer] The amount allocated in the metric.
        attr_reader :allocated

        # @return [Integer] The amount retained in the metric.
        attr_reader :retained
      end
    end
  end
end
