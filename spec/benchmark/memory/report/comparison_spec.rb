require "spec_helper"

RSpec.describe Benchmark::Memory::Report::Comparison do
  describe "#body" do
    it "is blank when the comparison is not possible" do
      comparison = described_class.new([])

      expect(comparison.body).to be_empty
    end

    it "outputs a comparison of the entries" do
      comparison = described_class.new([create_high_entry, create_low_entry])

      expect(comparison.body).not_to be_empty
    end

    it "gives a multiplier when entries aren't equal" do
      comparison = described_class.new([create_high_entry, create_low_entry])

      expect(comparison.body).to match(/4.00x/)
    end

    it "says 'same' when entries are equal" do
      comparison = described_class.new([create_low_entry, create_low_entry])

      expect(comparison.body).to match(/same/)
    end
  end

  describe "#entries" do
    it "is sorted from smallest allocation to largest" do
      high_entry = create_high_entry
      low_entry = create_low_entry

      comparison = described_class.new([high_entry, low_entry])

      expect(comparison.entries).to eq([low_entry, high_entry])
    end
  end

  def create_high_entry
    Benchmark::Memory::Report::Entry.new("high", create_measurement(10_000, 5_000))
  end
  alias_method :create_entry, :create_high_entry

  def create_low_entry
    Benchmark::Memory::Report::Entry.new("low", create_measurement(2_500, 1_250))
  end

  def create_measurement(allocated, retained)
    memsize = Benchmark::Memory::Measurement::Metric.new(:memsize, allocated, retained)
    objects = Benchmark::Memory::Measurement::Metric.new(:objects, 2_936_123, 0)
    strings = Benchmark::Memory::Measurement::Metric.new(:strings, 100, 99)

    Benchmark::Memory::Measurement.new(:strings => strings, :objects => objects, :memory => memsize)
  end
end
