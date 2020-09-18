# frozen_string_literal: true

require 'benchmark/memory/held_results/serializer'
require 'benchmark/memory/held_results/metric_serializer'
require 'benchmark/memory/measurement'

module Benchmark
  module Memory
    class HeldResults
      # Serialize measurements for holding between runs.
      class MeasurementSerializer < Serializer
        # Convert a JSON hash into a Measurement.
        #
        # @param hash [Hash] A JSON document hash.
        #
        # @return [Measurement]
        def load(hash)
          @object = Measurement.new(
            memory: MetricSerializer.load(hash['memory']),
            objects: MetricSerializer.load(hash['objects']),
            strings: MetricSerializer.load(hash['strings'])
          )
          self
        end

        # Convert the measurement to a Hash.
        #
        # @return [Hash] The measurement as a Hash.
        def to_h
          {
            memory: MetricSerializer.new(object.memory).to_h,
            objects: MetricSerializer.new(object.objects).to_h,
            strings: MetricSerializer.new(object.strings).to_h
          }
        end
      end
    end
  end
end
