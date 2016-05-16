source "https://rubygems.org"

gemspec

group :development do
  gem "guard"
  gem "guard-bundler"
  gem "guard-inch"
  gem "guard-rspec", "~> 4.6"
  gem "guard-rubocop"
  gem "inch"
  gem "mutant-rspec"
  gem "rake", "~> 10"
  gem "rubocop", "0.40.0"
  gem "yard", "~> 0.8"

  group :test do
    gem "pry"
  end
end

group :test do
  gem "codeclimate-test-reporter", :require => false
  gem "rspec", "~> 3.4"
  gem "simplecov"
end
