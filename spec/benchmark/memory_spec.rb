require "spec_helper"

RSpec.describe Benchmark::Memory do
  it "has a version number" do
    expect(Benchmark::Memory::VERSION).not_to be nil
  end

  it "exposes .memory on Benchmark" do
    expect(Benchmark).to respond_to(:memory)
  end

  describe ".memory" do
    it "raises an error when not given a block" do
      expect { Benchmark.memory }.to raise_error(
        Benchmark::Memory::ConfigurationError
      )
    end

    it "does not raise an error when given a block" do
      expect { Benchmark.memory {} }.not_to raise_error
    end
  end
end
