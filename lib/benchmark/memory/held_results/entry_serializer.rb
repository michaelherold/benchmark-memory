# frozen_string_literal: true

require 'benchmark/memory/held_results/serializer'
require 'benchmark/memory/held_results/measurement_serializer'
require 'benchmark/memory/report/entry'

module Benchmark
  module Memory
    class HeldResults
      # Serialize entrys for holding between runs.
      class EntrySerializer < Serializer
        # Convert a JSON hash into an Entry.
        #
        # @param hash [Hash] A JSON document hash.
        #
        # @return [Report::Entry]
        def load(hash)
          @object = Report::Entry.new(
            hash['item'],
            MeasurementSerializer.load(hash['measurement'])
          )
          self
        end

        # Convert the entry to a Hash.
        #
        # @return [Hash] The entry as a Hash.
        def to_h
          {
            item: object.label,
            measurement: MeasurementSerializer.new(object.measurement).to_h
          }
        end
      end
    end
  end
end
