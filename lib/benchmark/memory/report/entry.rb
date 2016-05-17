module Benchmark
  module Memory
    class Report
      # An entry in a report about a benchmark.
      class Entry
        # Instantiate a new entry.
        #
        # @param label [#to_s] The entry label.
        # @param measurement [Measurement] The measurements for the entry.
        def initialize(label, measurement)
          @label = label
          @measurement = measurement
        end

        # @return [#to_s] The entry label.
        attr_reader :label

        # @return [Measurement] The measurements for the entry.
        attr_reader :measurement

        # Get the total amount of memory allocated in the entry.
        #
        # @return [Integer]
        def allocated_memory
          measurement.memory.allocated
        end

        # Format the metrics for output into an IO.
        #
        # @return [String] the formatted output.
        def body
          body = StringIO.new
          body << formatted_label
          measurement.each_with_index.map do |metric, index|
            body << " " * 20 unless index == 0
            body << metric.to_s
            body << "\n"
          end
          body.string
        end

        def formatted_label
          rjust(label)
        end

        private

        # Right-justifies to a length of 20 or adds a line of padding when longer.
        #
        # @param label [#to_s] The label to justify.
        #
        # @return [String] The justified label.
        def rjust(label)
          label = label.to_s

          if label.size > 20
            "#{label}\n#{' ' * 20}"
          else
            label.rjust(20)
          end
        end
      end
    end
  end
end
