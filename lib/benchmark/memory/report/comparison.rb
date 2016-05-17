module Benchmark
  module Memory
    class Report
      # Compare entries against each other.
      class Comparison
        # Instantiate a new comparison.
        #
        # @param entries [Array<Entry>] The entries to compare.
        def initialize(entries)
          @entries = entries.sort_by(&:measurement)
        end

        # @return [Array<Entry>] The entries to compare.
        attr_reader :entries

        # Format the comparison for output on an IO.
        #
        # @return [String]
        def body
          return "" unless possible?

          output = StringIO.new
          best, rest = *entries
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

        # Check if the comparison is possible
        #
        # @return [TrueClass, FalseClass]
        def possible?
          entries.size > 1
        end
      end
    end
  end
end
