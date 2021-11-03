# frozen_string_literal: true

require 'forwardable'

module Benchmark
  module Memory
    class Report
      # An entry in a report about a benchmark.
      class Entry
        # Instantiate a new entry.
        #
        # @param label [#to_s] The entry label.
        # @param measurement [Measurement] The measurements for the entry.
        def initialize(label, measurement)
          @label = label
          @measurement = measurement
        end

        # @return [#to_s] The entry label.
        attr_reader :label

        # @return [Measurement] The measurements for the entry.
        attr_reader :measurement

        # Get the total amount of memory allocated in the entry.
        #
        # @param comparison [Comparison] The {Comparison} to compare.
        # @return [Integer]
        def compared_metric(comparison)
          measurement.public_send(comparison.metric).public_send(comparison.value)
        end
      end
    end
  end
end
