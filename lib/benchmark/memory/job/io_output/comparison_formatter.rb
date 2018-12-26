require 'benchmark/memory/helpers'
require 'benchmark/memory/job/io_output/metric_formatter'

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
            return '' unless comparison.possible?

            output = StringIO.new
            best, *rest = comparison.entries
            rest = Array(rest)

            add_best_summary(best, output)

            rest.each do |entry|
              add_comparison(entry, best, output)
            end

            output.string
          end

          private

          def add_best_summary(best, output)
            output << summary_message("%20s: %10i allocated\n", best)
          end

          def add_comparison(entry, best, output)
            output << summary_message('%20s: %10i allocated - ', entry)
            output << comparison_between(entry, best)
            output << "\n"
          end

          def comparison_between(entry, best)
            ratio = entry.allocated_memory.to_f / best.allocated_memory.to_f

            if ratio.abs > 1
              format('%.2fx more', ratio)
            else
              'same'
            end
          end

          def summary_message(message, entry)
            format(message, entry.label, entry.allocated_memory)
          end
        end
      end
    end
  end
end
