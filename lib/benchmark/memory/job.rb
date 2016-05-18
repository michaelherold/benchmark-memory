require "forwardable"
require "benchmark/memory/job/task"
require "benchmark/memory/job/io_output"
require "benchmark/memory/job/null_output"
require "benchmark/memory/held_results"
require "benchmark/memory/report"

module Benchmark
  module Memory
    # Encapsulate the memory measurements of reports.
    class Job
      extend Forwardable

      # Instantiate a job for containing memory performance reports.
      #
      # @param output [#puts] The output to use for showing the job results.
      # @param quiet [TrueClass, FalseClass] A flag for stopping output.
      #
      # @return [Job]
      def initialize(output: $stdout, quiet: false)
        @compare = false
        @full_report = Report.new
        @held_results = HeldResults.new
        @quiet = quiet
        @output = quiet? ? NullOutput.new : IOOutput.new(output)
        @tasks = []
      end

      # @return [Report] the full report of all measurements in the job.
      attr_reader :full_report

      # @return [Array<Task>] the measurement tasks to run.
      attr_reader :tasks

      # @return [Boolean] A flag indicating whether results are being held.
      def_delegator :@held_results, :holding?

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

      # Enable holding results to compare between separate runs.
      #
      # @param [String, IO] The location to save the held results.
      #
      # @return [void]
      def hold!(held_path)
        @held_results.path = held_path
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
        @held_results.load

        tasks.each do |task|
          held = run_task(task)

          if held
            @output.put_hold_notice
            break
          end
        end

        full_report
      end

      # Run a task.
      #
      # @param task [Task]
      #
      # @return [Boolean] A flag indicating whether to hold or not.
      def run_task(task)
        if @held_results.include?(task)
          measurement = @held_results[task.label]
          full_report.add_entry(task, measurement)
          return false
        else
          measurement = task.call
          entry = full_report.add_entry(task, measurement)
          @output.put_entry(entry)

          if task == tasks.last
            @held_results.cleanup
            false
          else
            @held_results.add_result(entry)
            @held_results.holding?
          end
        end
      end

      # Run a comparison of the entries and puts it on the output.
      #
      # @return [void]
      def run_comparison
        if compare? && full_report.comparable?
          @output.put_comparison(full_report.comparison)
        end
      end

      # Check whether the job is set to quiet.
      #
      # @return [TrueClass, FalseClass]
      def quiet?
        @quiet
      end
    end
  end
end
