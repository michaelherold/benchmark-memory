require "spec_helper"

RSpec.describe Benchmark::Memory::Job::Entry do
  describe ".new" do
    it "raises an ArgumentError when the action is not a callable" do
      expect do
        Benchmark::Memory::Job::Entry.new("label", nil)
      end.to raise_error(ArgumentError)
    end
  end

  describe "#call" do
    it "returns a measurement of the memory usage in the action" do
      action = -> {}
      entry = Benchmark::Memory::Job::Entry.new("empty proc", action)

      expect(entry.call).to be_a Benchmark::Memory::Measurement
    end
  end
end
