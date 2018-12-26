module Benchmark
  module Memory
    Error = Class.new(StandardError)

    ConfigurationError = Class.new(Error) do
      def message
        'You did not give a test block to your call to `Benchmark.memory`'
      end
    end
  end
end
