if ENV['COVERAGE'] || ENV['CI']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'benchmark/memory'
require 'pry'
require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.color = true
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10 if ENV['PROFILE']

  config.order = :random
  Kernel.srand config.seed
end
