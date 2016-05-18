require "benchmark/memory/errors"
require "benchmark/memory/job"
require "benchmark/memory/version"

# Performance benchmarking library
module Benchmark
  # Benchmark memory usage in code to benchmark different approaches.
  # @see https://github.com/michaelherold/benchmark-memory
  module Memory
    # Measure memory usage in report blocks.
    #
    # @param quiet [TrueClass, FalseClass] A flag to toggle benchmark output.
    #
    # @return [Report]
    def memory(quiet: false)
      unless block_given?
        fail(
          ConfigurationError,
          "You did not give a test block to your call to `Benchmark.memory`"
        )
      end

      job = Job.new(:quiet => quiet)

      yield job

      job.run
      job.run_comparison
      job.full_report
    end
  end

  extend Benchmark::Memory
end
