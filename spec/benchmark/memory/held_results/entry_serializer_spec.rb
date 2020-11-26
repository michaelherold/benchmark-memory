# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Benchmark::Memory::HeldResults::EntrySerializer do
  subject { described_class.new(entry) }

  let(:entry) do
    Benchmark::Memory::Report::Entry.new(
      'my super cool test',
      measurement
    )
  end

  let(:measurement) do
    Benchmark::Memory::Measurement.new(
      memory: Benchmark::Memory::Measurement::Metric.new(
        :memsize,
        measurement_memory_allocated,
        measurement_memory_retained
      ),
      objects: Benchmark::Memory::Measurement::Metric.new(
        :objects,
        2_936_123,
        0
      ),
      strings: Benchmark::Memory::Measurement::Metric.new(
        :strings,
        100,
        99
      )
    )
  end

  let(:measurement_memory_allocated) { 3_078_619 }
  let(:measurement_memory_retained) { 1_539_309 }

  let(:measurement_objects_allocated) { 2_936_123 }
  let(:measurement_objects_retained) { 0 }

  let(:measurement_strings_allocated) { 100 }
  let(:measurement_strings_retained) { 99 }

  let(:entry_json) do
    <<~JSON.chomp
      {"item":"my super cool test","measurement":{"memory":{"allocated":#{measurement_memory_allocated},"retained":#{measurement_memory_retained},"type":"memsize"},"objects":{"allocated":#{measurement_objects_allocated},"retained":#{measurement_objects_retained},"type":"objects"},"strings":{"allocated":#{measurement_strings_allocated},"retained":#{measurement_strings_retained},"type":"strings"}}}
    JSON
  end

  describe '.load' do
    subject { described_class.load entry_json }

    it 'converts JSON documents into entries' do
      expect(subject.measurement.memory.allocated)
        .to eq measurement_memory_allocated
      expect(subject.measurement.memory.retained)
        .to eq measurement_memory_retained

      expect(subject.measurement.objects.allocated)
        .to eq measurement_objects_allocated
      expect(subject.measurement.objects.retained)
        .to eq measurement_objects_retained

      expect(subject.measurement.strings.allocated)
        .to eq measurement_strings_allocated
      expect(subject.measurement.strings.retained)
        .to eq measurement_strings_retained
    end
  end

  describe '#to_s' do
    subject { super().to_s }

    it 'converts the entry into a JSON document' do
      is_expected.to eq entry_json
    end
  end
end
