require 'benchmark/memory/measurement/metric'

module Benchmark
  module Memory
    # Extracts metrics from a memory profiler result
    class MetricExtractor
      # Extracts the memory-specific metrics from a profiler result
      #
      # @param result [MemoryProfiler::Results]
      # @return [Benchmark::Memory::Measurement::Metric]
      def self.extract_memory(result)
        Measurement::Metric.new(
          :memsize,
          result.total_allocated_memsize,
          result.total_retained_memsize
        )
      end

      # Extracts the object-specific metrics from a profiler result
      #
      # @param result [MemoryProfiler::Results]
      # @return [Benchmark::Memory::Measurement::Metric]
      def self.extract_objects(result)
        Measurement::Metric.new(
          :objects,
          result.total_allocated,
          result.total_retained
        )
      end

      # Extracts the string-specific metrics from a profiler result
      #
      # @param result [MemoryProfiler::Results]
      # @return [Benchmark::Memory::Measurement::Metric]
      def self.extract_strings(result)
        Measurement::Metric.new(
          :strings,
          result.strings_allocated.size,
          result.strings_retained.size
        )
      end
    end
  end
end
