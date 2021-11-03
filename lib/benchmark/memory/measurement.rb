# frozen_string_literal: true

require 'forwardable'
require 'benchmark/memory/measurement/metric_extractor'

module Benchmark
  module Memory
    # Encapsulate the combined metrics of an action.
    class Measurement
      include Enumerable
      extend Forwardable

      # Create a Measurement from a MemoryProfiler::Results object.
      #
      # @param result [MemoryProfiler::Results]
      #   The results of a MemoryProfiler report.
      def self.from_result(result)
        memory = MetricExtractor.extract_memory(result)
        objects = MetricExtractor.extract_objects(result)
        strings = MetricExtractor.extract_strings(result)

        new(memory: memory, objects: objects, strings: strings)
      end

      # Instantiate a Measurement of memory usage.
      #
      # @param memory [Metric] The memory usage of an action.
      # @param objects [Metric] The object allocations of an action.
      # @param strings [Metric] The string allocations of an action.
      def initialize(memory:, objects:, strings:)
        @memory = memory
        @objects = objects
        @strings = strings
        @metrics = [@memory, @objects, @strings]
      end

      # @return [Metric] The memory allocation metric.
      attr_reader :memory

      # @return [Array<Metric>] The metrics for the measurement.
      attr_reader :metrics

      # @return [Metric] The object allocation metric.
      attr_reader :objects

      # @return [Metric] The string allocation metric.
      attr_reader :strings

      # Enumerate through the metrics when enumerating a measurement.
      def_delegator :metrics, :each
    end
  end
end
