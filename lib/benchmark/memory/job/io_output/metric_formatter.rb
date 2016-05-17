require "benchmark/memory/helpers"

module Benchmark
  module Memory
    class Job
      class IOOutput
        # Format metrics for use with the IOOutput.
        class MetricFormatter
          include Helpers

          # Instantiate a formatter to output a metric into an IO.
          #
          # @param metric [Measurement::Metric] The metric to format.
          def initialize(metric)
            @metric = metric
          end

          # @return metric [Metric] The metric to format.
          attr_reader :metric

          # Format metric to a string to put on the output.
          #
          # @return [String]
          def to_s
            [
              format("%s %s", scale(metric.allocated), metric.type),
              format("(%s retained)", scale(metric.retained)),
            ].join(" ")
          end
        end
      end
    end
  end
end
