require 'benchmark/memory/job/io_output/comparison_formatter'
require 'benchmark/memory/job/io_output/entry_formatter'

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
          @io.puts EntryFormatter.new(entry)
        end

        # Put the comparison onto the output.
        #
        # @return [void]
        def put_comparison(comparison)
          @io.puts
          @io.puts 'Comparison:'
          @io.puts ComparisonFormatter.new(comparison)
        end

        # Put the header onto the output.
        #
        # @return [void]
        def put_header
          @io.puts 'Calculating -------------------------------------'
        end

        # Put a notice that the execution is holding for another run.
        #
        # @return [void]
        def put_hold_notice
          @io.puts
          @io.puts 'Pausing here -- run Ruby again to ' \
                   'measure the next benchmark...'
        end
      end
    end
  end
end
