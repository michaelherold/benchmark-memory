# frozen_string_literal: true

module Benchmark
  module Memory
    class Report
      # Compare entries against each other.
      class Comparison
        extend Forwardable

        # Instantiate a new comparison.
        #
        # @param entries [Array<Entry>] The entries to compare.
        # @param comparator [Comparator] The comparator to use when generating.
        def initialize(entries, comparator)
          @entries = entries.sort_by(&comparator)
          @comparator = comparator
        end

        # @return [Comparator] The {Comparator} to use when generating the {Comparison}.
        attr_reader :comparator

        # @return [Array<Entry>] The entries to compare.
        attr_reader :entries

        # @!method metric
        #   @return [Symbol] The metric to compare, one of `:memory`, `:objects`, or `:strings`
        # @!method value
        #   @return [Symbol] The value to compare, one of `:allocated` or `:retained`
        def_delegators :@comparator, :metric, :value

        # Check if the comparison is possible
        #
        # @return [Boolean]
        def possible?
          entries.size > 1
        end
      end
    end
  end
end
