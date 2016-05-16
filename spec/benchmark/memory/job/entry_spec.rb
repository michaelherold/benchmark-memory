require "spec_helper"

RSpec.describe Benchmark::Memory::Job::Entry do
  describe ".new" do
    it "raises an ArgumentError when the action is not a callable" do
      expect do
        Benchmark::Memory::Job::Entry.new("label", nil)
      end.to raise_error(ArgumentError)
    end
  end
end
