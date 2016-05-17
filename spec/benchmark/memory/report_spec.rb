require "spec_helper"

RSpec.describe Benchmark::Memory::Report do
  it "is initialized with a blank list of entries" do
    report = described_class.new

    expect(report.entries).to be_empty
  end

  describe "#add_entry" do
    it "adds an entry to the list of entries" do
      report = described_class.new
      task = Benchmark::Memory::Job::Task.new("do nothing", -> {})
      measurement = create_measurement

      expect { report.add_entry(task, measurement) }.to change(report.entries, :count).by(1)
    end
  end

  def create_measurement
    metrics = {:memory => create_metric, :objects => create_metric, :strings => create_metric}
    Benchmark::Memory::Measurement.new(metrics)
  end

  def create_metric
    Benchmark::Memory::Measurement::Metric.new(:fake, 0, 0)
  end
end
