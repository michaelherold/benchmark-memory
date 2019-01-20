require File.expand_path('../lib/benchmark/memory/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'benchmark-memory'
  spec.version       = Benchmark::Memory::VERSION
  spec.authors       = ['Michael Herold']
  spec.email         = ['michael.j.herold@gmail.com']

  spec.summary       = 'Benchmark-style memory profiling for Ruby 2.1+'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/michaelherold/benchmark-memory'
  spec.license       = 'MIT'

  spec.files = %w[CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md Rakefile]
  spec.files += %w[benchmark-memory.gemspec]
  spec.files += Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'memory_profiler', '~> 0.9'
end
