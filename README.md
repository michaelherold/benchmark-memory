# benchmark-memory

[![CI](https://github.com/michaelherold/benchmark-memory/workflows/CI/badge.svg)][ci]
[![Code Climate](https://codeclimate.com/github/michaelherold/benchmark-memory/badges/gpa.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/michaelherold/benchmark-memory.svg?branch=master)][inch]

[ci]: https://github.com/michaelherold/benchmark-memory/actions
[codeclimate]: https://codeclimate.com/github/michaelherold/benchmark-memory
[inch]: http://inch-ci.org/github/michaelherold/benchmark-memory

benchmark-memory is a tool that helps you to benchmark the memory usage of different pieces of code. It leverages the power of [memory_profiler] to give you a metric of the total amount of memory allocated and retained by a block, as well as the number of objects and strings allocated and retained.

[memory_profiler]: https://github.com/SamSaffron/memory_profiler

## Installation

Add this line to your application's Gemfile:

```ruby
gem "benchmark-memory"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install benchmark-memory

## Usage

Following the examples of the built-in Benchmark and Evan Phoenix's [benchmark-ips], the most common way of using benchmark-memory is through the `Benchmark.memory` wrapper. An example might look like this:

```ruby
require "benchmark/memory"

# First method under test
def allocate_string
  "this string was dynamically allocated"
end

# Second method under test
def give_frozen_string
  "this string is frozen".freeze
end

Benchmark.memory do |x|
  x.report("dynamic allocation") { allocate_string }
  x.report("frozen string") { give_frozen_string }

  x.compare!
end
```

This example tests two methods that are defined inline. Note that you don't have to define them inline; you can just as easily use a method that you require before the benchmark or anything else that you can place in a block.

When you run this example, you see the difference between the two reports:

```txt
Calculating -------------------------------------
  dynamic allocation    40.000  memsize (     0.000  retained)
                         1.000  objects (     0.000  retained)
                         1.000  strings (     0.000  retained)
       frozen string     0.000  memsize (     0.000  retained)
                         0.000  objects (     0.000  retained)
                         0.000  strings (     0.000  retained)

Comparison:
       frozen string:          0 allocated
  dynamic allocation:         40 allocated - Infx more
```

Reading this output shows that the "dynamic allocation" example allocates one string that is not retained outside the scope of the block. The "frozen string" example, however, does not allocate anything because it reuses the frozen string that we created during the method definition.

[benchmark-ips]: https://github.com/evanphx/benchmark-ips

## Options

There are several options available when running a memory benchmark.

### Suppress all output (Quiet Mode)

```ruby
Benchmark.memory(:quiet => true)
```

Passing a `:quiet` flag to the `Benchmark.memory` method suppresses the output of the benchmark. You might find this useful if you want to run a benchmark as part of your test suite, where outputting to `STDOUT` would be disruptive.

### Enable comparison

```ruby
Benchmark.memory do |x|
  x.compare!
end
```

Calling `#compare!` on the job within the setup block of `Benchmark.memory` enables the output of the comparison section of the benchmark. Without it, the benchmark suppresses this section and you only get the raw numbers output during calculation.

### Hold results between invocations

```ruby
Benchmark.memory do |x|
  x.hold!("benchmark_results.json")
end
```

Often when you want to benchmark something, you compare two implementations of the same method. This is cumbersome because you have to keep two implementations side-by-side and call them in the same manner. Alternatively, you may want to compare how a method performs on two different versions of Ruby. To make both of these scenarios easier, you can enable "holding" on the benchmark.

By calling `#hold!` on the benchmark, you enable the benchmark to write to the given file to store its results in a file that can the benchmark reads in between invocations of your benchmark.

For example, imagine that you have a library that exposes a method called `Statistics.calculate_monthly_recurring_revenue` that you want to optimize for memory usage because it keeps causing your worker server to run out of memory. You make some changes to the method and commit them to an `optimize-memory` branch in Git.

To test the two implementations, you could then write this benchmark:

```ruby
require "benchmark/memory"

require "stats" # require your library file here
data = []       # set up the data that it will call here

Benchmark.memory do |x|
  x.report("original")  { Stats.monthly_recurring_revenue(data) }
  x.report("optimized") { Stats.monthly_recurring_revenue(data) }

  x.compare!
  x.hold("bm_recurring_revenue.json")
end
```

Note that the method calls are the same for both tests and that we have enabled result holding in the "bm_recurring_revenue.json" file.

You could then run the following (assuming you saved your benchmark as `benchmark_mrr.rb`:

```sh
$ git checkout master
$ ruby benchmark_mrr.rb
$ git checkout optimize-memory
$ ruby benchmark_mrr.rb
```

The first invocation of `ruby benchmark_mrr.rb` runs the benchmark in the "original" entry using your code in your `master` Git branch. The second invocation runs the benchmark in the "optimized" entry using the code in your `optimize-memory` Git branch. It then collates and compares the two results to show you the difference between the two.

When enabling holding, the benchmark writes to the file passed into the `#hold!` method. After you run all of the entries in the benchmark, the benchmark automatically cleans up its log by deleting the file.

## Supported Ruby Versions

This library aims to support and is [tested against][ci] the following Ruby versions:

* Ruby 2.5
* Ruby 2.6
* Ruby 2.7
* Ruby 3.0

If something doesn't work on one of these versions, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby versions, however, we will only give support for the versions listed above.

If you would like this library to support another Ruby version or implementation, you may volunteer to be a maintainer. Being a maintainer entails making sure all tests run and pass on that implementation. When something breaks on your implementation, you will be responsible for providing patches in a timely fashion. If critical issues for a particular implementation exist at the time of a major release, we may drop support for that Ruby version.

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver]. Report violations of this scheme as bugs. Specifically, if we release a minor or patch version that breaks backward compatibility, that version should be immediately yanked and/or a new version should be immediately released that restores compatibility. We will only introduce breaking changes to the public API with new major versions. As a result of this policy, you can (and should) specify a dependency on this gem using the [Pessimistic Version Constraint][pessimistic] with two digits of precision. For example:

    spec.add_dependency "benchmark-memory", "~> 0.1"

[pessimistic]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[semver]: http://semver.org/spec/v2.0.0.html

## Acknowledgments

This library wouldn't be possible without two projects and the people behind them:

* Sam Saffron's [memory_profiler] does all of the measurement of the memory allocation and retention in the benchmarks.
* I based much of the code around Evan Phoenix's [benchmark-ips] project, since it has a clean base from which to work and a logical organization. I also wanted to go for feature- and DSL-parity with it because I really like the way it works.

[benchmark-ips]: https://github.com/evanphx/benchmark-ips
[memory_profiler]: https://github.com/SamSaffron/memory_profiler

## License

The gem is available as open source under the terms of the [MIT License][license].

[license]: http://opensource.org/licenses/MIT.
