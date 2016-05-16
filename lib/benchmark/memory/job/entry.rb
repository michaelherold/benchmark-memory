module Benchmark
  module Memory
    class Job
      # Hold a labelled job for later measurement.
      class Entry
        # Instantiate a job entry for later measurement.
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
      end
    end
  end
end
