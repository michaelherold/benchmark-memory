require "spec_helper"

RSpec.describe Benchmark::Memory do
  it "has a version number" do
    expect(Benchmark::Memory::VERSION).not_to be nil
  end

  it "exposes .memory on Benchmark" do
    expect(Benchmark).to respond_to(:memory)
  end

  describe ".memory" do
    around(:each) do |spec|
      old_stdout = $stdout
      $stdout = StringIO.new
      spec.run
      $stdout = old_stdout
    end

    it "raises an error when not given a block" do
      expect { Benchmark.memory }.to raise_error(
        Benchmark::Memory::ConfigurationError
      )
    end

    it "returns a report" do
      expect(Benchmark.memory {}).to be_a(Benchmark::Memory::Report)
    end
  end
end
