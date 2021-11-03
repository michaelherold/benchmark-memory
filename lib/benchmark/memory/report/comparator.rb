# frozen_string_literal: true

module Benchmark
  module Memory
    class Report
      # Compares two {Entry} for the purposes of sorting and outputting a {Comparison}.
      class Comparator
        # @private
        METRICS = %i[memory objects strings].freeze

        # @private
        VALUES  = %i[allocated retained].freeze

        # Instantiates a {Comparator} from a spec given by {Job#compare!}
        #
        # @param spec [Hash<Symbol, Symbol>] The specification given for the {Comparator}
        # @return [Comparator]
        def self.from_spec(spec)
          raise ArgumentError, 'Only send a single metric and value, in the form memory: :allocated' if spec.length > 1

          metric, value = *spec.first
          metric ||= :memory
          value  ||= :allocated

          new(metric: metric, value: value)
        end

        # Instantiate a new comparator
        #
        # @param metric [Symbol] (see #metric)
        # @param value [Symbol] (see #value)
        def initialize(metric: :memory, value: :allocated)
          raise ArgumentError, "Invalid metric: #{metric.inspect}" unless METRICS.include? metric
          raise ArgumentError, "Invalid value: #{value.inspect}" unless VALUES.include? value

          @metric = metric
          @value = value
        end

        # @return [Symbol] The metric to compare, one of `:memory`, `:objects`, or `:strings`
        attr_reader :metric

        # @return [Symbol] The value to compare, one of `:allocated` or `:retained`
        attr_reader :value

        # Checks whether a {Comparator} equals another
        #
        # @param other [Benchmark::Memory::Comparator] The comparator to check against
        #
        # @return [Boolean]
        def ==(other)
          metric == other.metric && value == other.value
        end

        # Converts the {Comparator} to a Proc for passing to a block
        #
        # @return [Proc]
        def to_proc
          proc { |entry| entry.measurement.public_send(metric).public_send(value) }
        end
      end
    end
  end
end
