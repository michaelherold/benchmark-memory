# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Benchmark::Memory::Report::Comparator do
  describe '.from_spec' do
    it 'defaults to memory: :allocated when given nothing' do
      subject = described_class.from_spec({})

      expect(subject).to eq described_class.new(metric: :memory, value: :allocated)
    end

    it 'accepts all different types of metrics' do
      memory = described_class.from_spec({ memory: :allocated })
      expect(memory.metric).to eq :memory

      objects = described_class.from_spec({ objects: :allocated })
      expect(objects.metric).to eq :objects

      strings = described_class.from_spec({ strings: :allocated })
      expect(strings.metric).to eq :strings
    end

    it 'raises an error if given an invalid metric' do
      expect { described_class.from_spec({ unknown: :allocated }) }
        .to raise_error ArgumentError
    end

    it 'raises an error if given an invalid value' do
      expect { described_class.from_spec({ memory: :unknown }) }
        .to raise_error ArgumentError
    end

    it 'raises an error if given more than one metric' do
      expect { described_class.from_spec({ memory: :allocated, objects: :retained }) }
        .to raise_error ArgumentError
    end
  end
end
