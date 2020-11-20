# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Benchmark::Memory::HeldResults::EntrySerializer do
  describe '.load' do
    it 'converts JSON documents into entries' do
      document =
        '{"item":"my super cool test",' \
        '"measurement":' \
        '{"memory":' \
        '{"allocated":3078619,"retained":1539309,"type":"memsize"},' \
        '"objects":{"allocated":2936123,"retained":0,"type":"objects"},' \
        '"strings":{"allocated":100,"retained":99,"type":"strings"}}}'

      entry = described_class.load(document)
      result = described_class.new(entry).to_s

      expect(result).to eq(document)
    end
  end

  describe '#to_s' do
    it 'converts the entry into a JSON document' do
      result = described_class.new(create_entry).to_s

      expected_result =
        '{"item":"my super cool test",' \
        '"measurement":' \
        '{"memory":' \
        '{"allocated":3078619,"retained":1539309,"type":"memsize"},' \
        '"objects":{"allocated":2936123,"retained":0,"type":"objects"},' \
        '"strings":{"allocated":100,"retained":99,"type":"strings"}}}'

      expect(result).to eq(expected_result)
    end
  end

  def create_entry
    Benchmark::Memory::Report::Entry.new(
      'my super cool test',
      create_measurement
    )
  end

  def create_measurement
    memsize = Benchmark::Memory::Measurement::Metric.new(
      :memsize,
      3_078_619,
      1_539_309
    )
    objects = Benchmark::Memory::Measurement::Metric.new(
      :objects,
      2_936_123,
      0
    )
    strings = Benchmark::Memory::Measurement::Metric.new(
      :strings,
      100,
      99
    )

    Benchmark::Memory::Measurement.new(
      strings: strings,
      objects: objects,
      memory: memsize
    )
  end
end
