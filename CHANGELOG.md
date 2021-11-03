# Change Log

All notable changes to this project will be documented in this file. This project adheres to [Semantic Versioning 2.0.0][semver]. Any violations of this scheme are considered to be bugs.

[semver]: http://semver.org/spec/v2.0.0.html

## [0.2.0](https://github.com/michaelherold/benchmark-memory/compare/v0.1.1...v0.2.0)

### Added

- [#11](https://github.com/michaelherold/benchmark-memory/pull/11): Drop support for Ruby < 2.4 - [@dblock](https://github.com/dblock).
- [#23](https://github.com/michaelherold/benchmark-memory/pull/23): Allow for sorting the comparison by different criteria - [@michaelherold](https://github.com/michaelherold).

### Updated

- [#16](https://github.com/michaelherold/benchmark-memory/pull/16): Updated Rubocop to ~> 1 and Ruby to 2.5.0+ - [@AlexWayfer](https://github.com/AlexWayfer).
- [#19](https://github.com/michaelherold/benchmark-memory/pull/19): Updated to `memory_profiler` 1.0 - [@AlexWayfer](https://github.com/AlexWayfer).

## [0.1.2](https://github.com/michaelherold/benchmark-memory/compare/v0.1.1...v0.1.2) - 2017-01-30

### Fixed

- [#4](https://github.com/michaelherold/benchmark-memory/pull/4): Fix a small bug when StringIO wasn't properly required - [@rzane](https://github.com/rzane).

## [0.1.1](https://github.com/michaelherold/benchmark-memory/compare/v0.1.0...v0.1.1) - 2016-06-10

### Fixed

- Printing comparisons for multiple entries.

## [0.1.0](https://github.com/michaelherold/benchmark-memory/tree/v0.1.0) - 2016-05-18

### Added

- Main `Benchmark.memory` method.
- Holding results between invocations for measuring implementations on different versions of Ruby or different versions of libraries.
- Quiet mode, with no command line output.
