# frozen_string_literal: true

require 'json'

module Benchmark
  module Memory
    class HeldResults
      # Serialize objects for holding between runs.
      class Serializer
        # Load an object from a JSON document.
        #
        # @param json [String] A JSON document as a string.
        #
        # @return [Object] The object converted from the JSON document.
        def self.load(json)
          json = JSON.parse(json) if json.is_a?(String)
          new.load(json).object
        end

        # Instantiate a new serializer.
        #
        # @param object [Object] The object to serialize.
        def initialize(object = nil)
          @object = object
        end

        # @return [Object] The object to serialize.
        attr_reader :object

        # Convert a JSON document into an object.
        #
        # @param _hash [Hash] A JSON document hash.
        #
        # @return [Object]
        # @raise [NotImplementedError]
        #   If the inheriting subclass didn't implement.
        def load(_hash)
          raise(
            NotImplementedError,
            'You must implement a concrete version in a subclass'
          )
        end

        # Convert the object to a Hash.
        #
        # @return [Hash] The object as a Hash.
        # @raise [NotImplementedError]
        #   If the inheriting subclass didn't implement.
        def to_h
          raise(
            NotImplementedError,
            'You must implement a concrete version in a subclass'
          )
        end

        # Convert the object to a JSON document.
        #
        # @return [String] The object as a JSON document.
        def to_json(*_args)
          JSON.generate(to_h)
        end
        alias to_s to_json
      end
    end
  end
end
