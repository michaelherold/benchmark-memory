require "stringio"
require "benchmark/memory/helpers"
require "benchmark/memory/job/io_output/metric_formatter"

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
            entry.measurement.each_with_index.map do |metric, index|
              output << " " * 20 unless index == 0
              output << MetricFormatter.new(metric)
              output << "\n"
            end
            output.string
          end
        end
      end
    end
  end
end
