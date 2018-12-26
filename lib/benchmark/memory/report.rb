require 'benchmark/memory/report/comparison'
require 'benchmark/memory/report/entry'

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
      # @return [Entry] the newly created entry.
      def add_entry(task, measurement)
        entry = Entry.new(task.label, measurement)
        entries.push(entry)
        entry
      end

      # Return true if the report is comparable.
      #
      # @return [Boolean]
      def comparable?
        comparison.possible?
      end

      # Compare the entries within a report.
      #
      # @return [Comparison]
      def comparison
        @comparison ||= Comparison.new(entries)
      end
    end
  end
end
