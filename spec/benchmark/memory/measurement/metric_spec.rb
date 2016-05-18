require "spec_helper"

RSpec.describe Benchmark::Memory::Measurement::Metric do
  describe "#to_s" do
    it "is of consistent length" do
      examples = [0, 100, 1_000, 1_000_000, 1_000_000_000, 1_000_000_000_000]
      lengths = examples.map do |i|
        metric = described_class.new(:fake, i * 2, i)
        metric.to_s.length
      end

      expect(lengths.min).to eq(lengths.max)
    end
  end
end
