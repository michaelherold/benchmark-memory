# frozen_string_literal: true

require 'benchmark/memory/held_results/serializer'
require 'benchmark/memory/measurement/metric'

module Benchmark
  module Memory
    class HeldResults
      # Serialize metrics for holding between runs.
      class MetricSerializer < Serializer
        # Convert a JSON hash into a Metric.
        #
        # @param hash [Hash] A JSON document hash.
        #
        # @return [Measurement::Metric]
        #
        def load(hash)
          @object = Measurement::Metric.new(
            hash['type'],
            hash['allocated'],
            hash['retained']
          )
          self
        end

        # Convert the metric to a Hash.
        #
        # @return [Hash] The metric as a Hash.
        def to_h
          {
            allocated: object.allocated,
            retained: object.retained,
            type: object.type
          }
        end
      end
    end
  end
end
