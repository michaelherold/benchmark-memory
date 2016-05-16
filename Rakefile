require "bundler"
Bundler.setup
Bundler::GemHelper.install_tasks

require "inch/rake"
Inch::Rake::Suggest.new(:inch)

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"
RuboCop::RakeTask.new(:rubocop)

require "yard/rake/yardoc_task"
YARD::Rake::YardocTask.new(:yard)

task :mutant do
  command = [
    "bundle exec mutant",
    "--include lib",
    "--require interactor-contracts",
    "--use rspec",
    "Interactor::Contracts*",
  ].join(" ")

  system command
end

task :default => [:spec, :rubocop, :yard, :inch]
