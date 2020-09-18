# frozen_string_literal: true

require 'stringio'
require 'benchmark/memory/helpers'
require 'benchmark/memory/job/io_output/metric_formatter'

module Benchmark
  module Memory
    class Job
      class IOOutput
        # Format entries for use with the IOOutput.
        class EntryFormatter
          include Helpers

          # Instantiate a formatter to output an entry into an IO.
          #
          # @param entry [Entry] The entry to format.
          def initialize(entry)
            @entry = entry
          end

          # @return [Entry] The entry to format.
          attr_reader :entry

          # Format entry to a string to put on the output.
          #
          # @return [String]
          def to_s
            output = StringIO.new
            output << rjust(entry.label)

            first, *rest = *entry.measurement

            output << "#{MetricFormatter.new(first)}\n"
            rest.each do |metric|
              output << "#{' ' * 20}#{MetricFormatter.new(metric)}\n"
            end

            output.string
          end
        end
      end
    end
  end
end
