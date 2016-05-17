require "spec_helper"

RSpec.describe Benchmark::Memory::Job do
  describe "#report" do
    it "raises an ArgumentError when no block is specified" do
      job = Benchmark::Memory::Job.new

      expect { job.report("riddle me this") }.to raise_error(ArgumentError)
    end

    it "adds a task to the list of tasks in the job" do
      job = Benchmark::Memory::Job.new

      expect { job.report("riddle me that") {} }.to change(job.tasks, :count).by(1)
    end
  end

  describe "#run" do
    it "adds an entry to the report for each task" do
      job = Benchmark::Memory::Job.new
      job.report("with you") {}
      job.report("my brown eyed girl") {}

      expect { job.run }.to change(job.full_report.entries, :count).by(2)
    end
  end
end
