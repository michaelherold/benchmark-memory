# frozen_string_literal: true

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
            baseline, *rest = comparison.entries
            rest = Array(rest)

            add_baseline_summary(baseline, output)

            rest.each do |entry|
              add_comparison(entry, baseline, output)
            end

            output.string
          end

          private

          def add_baseline_summary(baseline, output)
            output << summary_message('%20s: %10i %s', baseline)
            output << "\n"
          end

          def add_comparison(entry, baseline, output)
            output << summary_message('%20s: %10i %s - ', entry)
            output << comparison_between(entry, baseline)
            output << "\n"
          end

          def comparison_between(entry, baseline)
            ratio = entry.compared_metric(comparison).to_f / baseline.compared_metric(comparison)

            if ratio > 1
              format('%.2fx more', ratio)
            elsif ratio < 1
              format('%.2fx less', 1.0 / ratio)
            else
              'same'
            end
          end

          def summary_message(message, entry)
            format(message, entry.label, entry.compared_metric(comparison), comparison.value)
          end
        end
      end
    end
  end
end
