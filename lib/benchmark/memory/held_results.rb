require "forwardable"
require "benchmark/memory/held_results/entry_serializer"

module Benchmark
  module Memory
    # Collate results that should be held until the next run.
    class HeldResults
      extend Forwardable

      # Instantiate a new set of held results on a path.
      #
      # @param path [String, IO] The path to write held results to.
      def initialize(path = nil)
        @path = path
        @results = {}
      end

      # @return [String, IO] The path to write held results to.
      attr_accessor :path

      # @return [Hash{String => Measurement}] Held results from previous runs.
      attr_reader :results

      # Allow Hash-like access to the results without asking for them.
      def_delegator :@results, :[]

      # Add a result to the held results.
      #
      # @param entry [Report::Entry] The entry to hold.
      #
      # @return [void]
      def add_result(entry)
        with_hold_file("a") do |file|
          file.write EntrySerializer.new(entry)
          file.write "\n"
        end
      end

      # Check whether any results have been stored.
      #
      # @return [Boolean]
      def any?
        if @path.is_a?(String)
          File.exist?(@path)
        else
          @path.size > 0 # rubocop:disable Style/ZeroLengthPredicate
        end
      end

      # Clean up the results after all results have been collated.
      #
      # @return [void]
      def cleanup
        if @path.is_a?(String) && File.exist?(@path)
          File.delete(@path)
        end
      end

      # Check whether to hold results.
      #
      # @return [Boolean]
      def holding?
        !!@path
      end

      # Check whether an entry has been added to the results.
      #
      # @param entry [#label] The entry to check.
      #
      # @return [Boolean]
      def include?(entry)
        holding? && any? && results.key?(entry.label)
      end

      # Load results from the serialized output.
      #
      # @return [void]
      def load
        return unless holding? && any?

        results = with_hold_file do |file|
          file.map { |line| EntrySerializer.load(line) }
        end
        @results = Hash[results.map do |result|
          [result.label, result.measurement]
        end]
      end

      private

      # Execute a block on the hold file.
      #
      # @param access_mode [String] The mode to use when opening the file.
      # @param block [Proc] The block to execute on each line of the file.
      #
      # @return [void]
      def with_hold_file(access_mode = "r", &_block)
        return unless @path

        if @path.is_a?(String)
          File.open(@path, access_mode) do |f|
            yield f
          end
        else
          yield @path
        end
      end
    end
  end
end
