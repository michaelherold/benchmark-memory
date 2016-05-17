require "spec_helper"

RSpec.describe Benchmark::Memory::Helpers do
  describe "#scale" do
    it "scales values into human terms" do
      scale = ->(value) { Benchmark::Memory::Helpers.scale(value) }

      expect(scale.call(1)).to                      eq("     1.000 ")
      expect(scale.call(123)).to                    eq("   123.000 ")
      expect(scale.call(1_234)).to                  eq("     1.234k")
      expect(scale.call(1_234_567)).to              eq("     1.235M")
      expect(scale.call(1_234_567_890)).to          eq("     1.235B")
      expect(scale.call(1_234_567_890_123)).to      eq("     1.235T")
      expect(scale.call(1_234_567_890_123_456)).to  eq("     1.235Q")
    end
  end
end
