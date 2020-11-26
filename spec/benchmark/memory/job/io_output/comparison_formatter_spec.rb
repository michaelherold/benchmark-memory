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
  end

  def comparison(entries)
    Benchmark::Memory::Report::Comparison.new(entries)
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
    Benchmark::Memory::Measurement.new(
      memory: create_measurement_memory_metric(
        allocated,
        retained
      ),
      objects: create_measurement_objects_metric,
      strings: create_measurement_strings_metric
    )
  end

  def create_measurement_memory_metric(allocated, retained)
    Benchmark::Memory::Measurement::Metric.new(:memsize, allocated, retained)
  end

  def create_measurement_objects_metric
    Benchmark::Memory::Measurement::Metric.new(:objects, 2_936_123, 0)
  end

  def create_measurement_strings_metric
    Benchmark::Memory::Measurement::Metric.new(:strings, 100, 99)
  end
end
