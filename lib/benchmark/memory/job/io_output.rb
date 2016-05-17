module Benchmark
  module Memory
    class Job
      # Output the results of jobs into an IO.
      class IOOutput
        # Instantiate a new output that writes to an IO.
        #
        # @param io [#puts] The IO to write on.
        def initialize(io)
          @io = io
        end

        # Put the entry onto the output.
        #
        # @return [void]
        def put_entry(entry)
          @io.puts entry.body
        end

        # Put the header onto the output
        #
        # @return [void]
        def put_header
          @io.puts "Calculating -------------------------------------"
        end
      end
    end
  end
end
