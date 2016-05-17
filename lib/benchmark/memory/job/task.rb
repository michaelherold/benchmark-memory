require "memory_profiler"
require "benchmark/memory/measurement"

module Benchmark
  module Memory
    class Job
      # Hold a labelled job for later measurement.
      class Task
        # Instantiate a job task for later measurement.
        #
        # @param label [#to_s] The label for the benchmark.
        # @param action [#call] The code to be measured.
        #
        # @raise [ArgumentError] if the action does not respond to `#call`.
        def initialize(label, action)
          unless action.respond_to?(:call)
            fail ArgumentError, "Invalid action (#{@action.inspect} does not respond to call)"
          end

          @label = label
          @action = action
        end

        # @return [#call] The code to be measured.
        attr_reader :action

        # @return [#to_s] The label for the benchmark.
        attr_reader :label

        # Call the action and report on its memory usage.
        #
        # @return [Measurement] the memory usage measurement of the code.
        def call
          result = while_measuring_memory_usage { action.call }

          Measurement.from_result(result)
        end

        private

        def while_measuring_memory_usage(&block)
          MemoryProfiler.report({}, &block)
        end
      end
    end
  end
end
