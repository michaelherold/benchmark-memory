require "spec_helper"

RSpec.describe Benchmark::Memory::Job do
  describe "#report" do
    it "raises an ArgumentError when no block is specified" do
      job = create_job

      expect { job.report("riddle me this") }.to raise_error(ArgumentError)
    end

    it "adds a task to the list of tasks in the job" do
      job = create_job

      expect { job.report("riddle me that") {} }.to change(job.tasks, :count).by(1)
    end
  end

  describe "#run" do
    it "adds an entry to the report for each task" do
      job = create_job
      job.report("with you") {}
      job.report("my brown eyed girl") {}

      expect { job.run }.to change(job.full_report.entries, :count).by(2)
    end
  end

  describe "#run_comparison" do
    it "does not run if there are no entries" do
      job, output = create_job_and_output

      job.run
      job.run_comparison

      expect(output.string).not_to match(/Comparison/)
    end

    it "runs when there are entries and the job is configured to compare" do
      job, output = create_job_and_output
      job.report("with you") {}
      job.report("my brown eyed girl") {}
      job.compare!

      job.run
      job.run_comparison

      expect(output.string).to match(/Comparison/)
    end
  end

  describe "#quiet?" do
    it "prevents any output from being written" do
      job, output = create_job_and_output(:quiet => true)
      job.report("with you") {}
      job.report("my brown eyed girl") {}
      job.compare!

      job.run
      job.run_comparison

      expect(output.string).to be_empty
    end
  end

  def create_job_and_output(quiet: false)
    output = StringIO.new
    job = Benchmark::Memory::Job.new(:output => output, :quiet => quiet)

    [job, output]
  end

  def create_job
    create_job_and_output.first
  end
end
