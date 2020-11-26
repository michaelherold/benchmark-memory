# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Benchmark::Memory::Job::IOOutput do
  describe '#put_entry' do
    it 'outputs onto the passed IO' do
      entry = create_entry
      io = StringIO.new
      output = described_class.new(io)

      output.put_entry(entry)

      expect(io.string).not_to be_empty
    end
  end

  def create_entry
    Benchmark::Memory::Report::Entry.new(
      'my super cool test',
      create_measurement
    )
  end

  def create_measurement
    Benchmark::Memory::Measurement.new(
      memory: create_measurement_memory_metric,
      objects: create_measurement_objects_metric,
      strings: create_measurement_strings_metric
    )
  end

  def create_measurement_memory_metric
    Benchmark::Memory::Measurement::Metric.new(:memsize, 3_078_619, 1_539_309)
  end

  def create_measurement_objects_metric
    Benchmark::Memory::Measurement::Metric.new(:objects, 2_936_123, 0)
  end

  def create_measurement_strings_metric
    Benchmark::Memory::Measurement::Metric.new(:strings, 100, 99)
  end
end
