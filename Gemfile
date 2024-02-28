# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-inch'
  gem 'guard-rspec', '~> 4.6'
  gem 'guard-rubocop'
  gem 'rake', '>= 12.3.3'
  gem 'yard', '~> 0.9.35'

  group :ci do
    gem 'inch'
    gem 'rubocop', '~> 1'
  end

  group :test do
    gem 'pry'
  end
end

group :test do
  gem 'rspec', '~> 3.4'
  gem 'simplecov', '> 0.20'
end
