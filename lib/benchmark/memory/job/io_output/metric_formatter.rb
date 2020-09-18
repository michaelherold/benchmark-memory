# frozen_string_literal: true

require 'benchmark/memory/helpers'

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

          # @return [Metric] The metric to format.
          attr_reader :metric

          # Format metric to a string to put on the output.
          #
          # @return [String]
          def to_s
            [allocated_message, retained_message].join(' ')
          end

          private

          # @return [String] the formated string for allocated memory
          def allocated_message
            format(
              '%<allocated>s %<type>s',
              allocated: scale(metric.allocated),
              type: metric.type
            )
          end

          # @return [String] the formated string for retained memory
          def retained_message
            format(
              '(%<retained>s retained)',
              retained: scale(metric.retained)
            )
          end
        end
      end
    end
  end
end
