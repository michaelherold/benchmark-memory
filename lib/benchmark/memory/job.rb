require "benchmark/memory/report"

module Benchmark
  module Memory
    # Encapsulate the memory measurements of reports.
    class Job
      # Instantiate a job for containing memory performance reports.
      # @return [Job]
      def initialize
        @full_report = Report.new
      end

      # @return [Report] the full report of all measurements in the job.
      attr_reader :full_report

      # Run the job and outputs its full report.
      #
      # @return [Report]
      def run
        full_report
      end
    end
  end
end
