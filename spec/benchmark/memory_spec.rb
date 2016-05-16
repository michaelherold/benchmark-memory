require "spec_helper"

RSpec.describe Benchmark::Memory do
  it "has a version number" do
    expect(Benchmark::Memory::VERSION).not_to be nil
  end
end
