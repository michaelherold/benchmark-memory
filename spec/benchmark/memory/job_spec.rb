require "spec_helper"

RSpec.describe Benchmark::Memory::Job do
  describe "#report" do
    it "raises an ArgumentError when no block is specified" do
      job = Benchmark::Memory::Job.new

      expect { job.report("riddle me this") }.to raise_error(ArgumentError)
    end

    it "adds an entry to the list of entries in the job" do
      job = Benchmark::Memory::Job.new

      expect { job.report("riddle me that") {} }.to change(job.entries, :count).by(1)
    end
  end
end
