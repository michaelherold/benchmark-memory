require "benchmark/memory/report/entry"

module Benchmark
  module Memory
    # Hold the results of a set of benchmarks.
    class Report
      # Instantiate a report to hold entries of tasks and measurements.
      #
      # @return [Report]
      def initialize
        @entries = []
      end

      # @return [Array<Entry>] The entries in the report.
      attr_reader :entries

      # Add an entry to the report.
      #
      # @param task [Job::Task] The task to report about.
      # @param measurement [Measurement] The measurements from the task.
      #
      # @return [void]
      def add_entry(task, measurement)
        entries.push Entry.new(task.label, measurement)
      end
    end
  end
end
