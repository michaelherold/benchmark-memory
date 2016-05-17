require "benchmark/memory/helpers"
require "benchmark/memory/job/io_output/metric_formatter"

module Benchmark
  module Memory
    class Job
      class IOOutput
        # Format a comparison for use with the IOOutput.
        class ComparisonFormatter
          include Helpers

          # Instantiate a formatter to output an comparison into an IO.
          #
          # @param comparison [Report::Comparison] The comparison to format.
          def initialize(comparison)
            @comparison = comparison
          end

          # @return [Report::Comparison] The comparison to format.
          attr_reader :comparison

          # Format comparison to a string to put on the output.
          #
          # @return [String]
          def to_s
            return "" unless comparison.possible?

            output = StringIO.new
            best, rest = *comparison.entries
            rest = Array(rest)

            output << format("%20s: %10i allocated\n", best.label, best.allocated_memory)

            rest.each do |entry|
              output << format("%20s: %10i allocated - ", entry.label, entry.allocated_memory)

              ratio = entry.allocated_memory.to_f / best.allocated_memory.to_f
              comparison =
                if ratio.abs > 1
                  format("%.2fx more", ratio)
                else
                  "same"
                end

              output << comparison
            end

            output.string
          end
        end
      end
    end
  end
end
