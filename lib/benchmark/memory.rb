require "benchmark/memory/errors"
require "benchmark/memory/helpers"
require "benchmark/memory/job"
require "benchmark/memory/version"

# Performance benchmarking library
module Benchmark
  # Benchmark memory usage in code to benchmark different approaches.
  # @see https://github.com/michaelherold/benchmark-memory
  module Memory
    # Measure memory usage in report blocks.
    #
    # @return [Report]
    def memory
      unless block_given?
        fail ConfigurationError, "You did you give a test block to your call to `Benchmark.memory`".freeze
      end
      job = Job.new
      yield job
      job.run
    end
  end

  extend Benchmark::Memory
end
