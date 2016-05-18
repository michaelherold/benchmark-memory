# Contributing

In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project. Here are some ways *you* can contribute:

* Use alpha, beta, and pre-release versions.
* Report bugs.
* Suggest new features.
* Write or edit documentation.
* Write specifications.
* Write code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace).
* Refactor code.
* Fix [issues][].
* Review patches.

[issues]: https://github.com/michaelherold/benchmark-memory/issues

## Submitting an Issue

We use the [GitHub issue tracker][issues] to track bugs and features. Before submitting a bug report or feature request, check to make sure it hasn't already been submitted.

When submitting a bug report, please include a [Gist](https://gist.github.com) that includes a stack trace and any details that may be necessary to reproduce the bug, including your gem version, Ruby version, and operating system.

Ideally, a bug report should include a pull request with failing specs.

## Submitting a Pull Request

1. [Fork the repository](http://help.github.com/fork-a-repo/).
2. [Create a topic branch](http://learn.github.com/p/branching.html).
3. Add specs for your unimplemented feature or bug fix.
4. Run `bundle exec rake spec`. If your specs pass, return to step 3.
5. Implement your feature or bug fix.
6. Run `bundle exec rake`. If your specs or any of the linters fail, return to step 5.
7. Open `coverage/index.html`. If your changes are not completely covered by your tests, return to step 3.
8. Add documentation for your feature or bug fix.
9. Run `bundle exec inch`. If your changes are below a B in documentation, go back to step 8.
10. Commit and push your changes.
11. [Submit a pull request](http://help.github.com/send-pull-requests/).

## Tools to help you succeed

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

When writing code, you can use the helper application [Guard][guard] to automatically run tests and coverage tools whenever you modify and save a file. This helps to eliminate the tedium of running tests manually and reduces the chance that you will accidentally forget to run the tests. To use Guard, run `bundle exec guard`.

Before committing code, run `rake` to check that the code conforms to the style guidelines of the project, that all of the tests are green (if you're writing a feature; if you're only submitting a failing test, then it does not have to pass!), and that the changes are sufficiently documented.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org][rubygems].

[guard]: http://guardgem.org
[rubygems]: https://rubygems.org
