# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Benchmark::Memory::Job::IOOutput::ComparisonFormatter do
  describe '#to_s' do
    it 'is blank when the comparison is not possible' do
      comp = comparison([])
      formatter = described_class.new(comp)

      expect(formatter.to_s).to be_empty
    end

    it 'outputs a comparison of the entries' do
      entries = [create_high_entry, create_medium_entry, create_low_entry]
      comp = comparison(entries)
      formatter = described_class.new(comp)

      output = formatter.to_s

      expect(output).not_to be_empty
      expect(output.split("\n").size).to eq(entries.length)
    end

    it "gives a multiplier when entries aren't equal" do
      comp = comparison([create_high_entry, create_low_entry])
      formatter = described_class.new(comp)

      expect(formatter.to_s).to match(/4.00x/)
    end

    it "says 'same' when entries are equal" do
      comp = comparison([create_low_entry, create_low_entry])
      formatter = described_class.new(comp)

      expect(formatter.to_s).to match(/same/)
    end

    it 'does not output a comparison for the baseline' do
      entries = [create_low_entry, create_high_entry]
      comp = Benchmark::Memory::Report::Comparison.new(
        entries,
        Benchmark::Memory::Report::Comparator.new(order: :baseline)
      )

      formatter = described_class.new(comp)

      expect(formatter.to_s).to match(/2500 allocated\n.*/).and(match(/10000 allocated - 4.00x more/))
    end
  end

  def comparison(entries)
    Benchmark::Memory::Report::Comparison.new(entries, Benchmark::Memory::Report::Comparator.new)
  end

  def create_high_entry
    Benchmark::Memory::Report::Entry.new(
      'high',
      create_measurement(10_000, 5_000)
    )
  end
  alias_method :create_entry, :create_high_entry

  def create_low_entry
    Benchmark::Memory::Report::Entry.new(
      'low',
      create_measurement(2_500, 1_250)
    )
  end

  def create_medium_entry
    Benchmark::Memory::Report::Entry.new(
      'medium',
      create_measurement(5_000, 2_500)
    )
  end

  def create_measurement(allocated, retained)
    memsize = Benchmark::Memory::Measurement::Metric.new(
      :memsize,
      allocated,
      retained
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
