require "benchmark/memory/job/task"
require "benchmark/memory/job/io_output"
require "benchmark/memory/report"

module Benchmark
  module Memory
    # Encapsulate the memory measurements of reports.
    class Job
      # Instantiate a job for containing memory performance reports.
      #
      # @param output [#puts] The output to use for showing the job results.
      #
      # @return [Job]
      def initialize(output: $stdout)
        @compare = false
        @full_report = Report.new
        @output = IOOutput.new(output)
        @tasks = []
      end

      # @return [Report] the full report of all measurements in the job.
      attr_reader :full_report

      # @return [Array<Task>] the measurement tasks to run.
      attr_reader :tasks

      # Check whether the job should do a comparison.
      #
      # @return [TrueClass, FalseClass]
      def compare?
        @compare
      end

      # Enable output of a comparison of the different tasks.
      #
      # @return [void]
      def compare!
        @compare = true
      end

      # Add a measurement entry to the job to measure the specified block.
      #
      # @param label [String] The label for the measured code.
      # @param block [Proc] Code the measure.
      #
      # @raise [ArgumentError] if no code block is specified.
      def report(label = "", &block)
        fail ArgumentError, "You did not specify a block for the item" unless block_given?

        tasks.push Task.new(label, block)
      end

      # Run the job and outputs its full report.
      #
      # @return [Report]
      def run
        @output.put_header

        tasks.each do |task|
          measurement = task.call
          entry = full_report.add_entry(task, measurement)
          @output.put_entry(entry)
        end

        full_report
      end

      # Run a comparison of the entries and puts it on the output.
      #
      # @return [void]
      def run_comparison
        if compare? && full_report.comparable?
          @output.put_comparison(full_report.comparison)
        end
      end
    end
  end
end
