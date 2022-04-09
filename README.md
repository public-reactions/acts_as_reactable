# ActsAsReactable

![build](https://github.com/public-reactions/acts_as_reactable/actions/workflows/main.yml/badge.svg)

TODO: Add badge for gem
TODO: Add badge for coverage

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add acts_as_reactable

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install acts_as_reactable

## Usage

### 1. create the Reaction model

### 2. annotate reactable and reactor models

### 3. creating/updating reactions

### 4. deleting reactions

### 5. aggregate/summary of reactions

## FAQ

### Why saving the emoji character instead of "smily_face"

- Technically, there's no concrete name/key/id for emoji (and modifiers like skin tone). The [CLDR short names](https://unicode.org/emoji/format.html#col-name) "vary by language" and "may change".
- It's easier to store since any modern database supports 
- It's easier to validate with libs/regex (e.g. [unicode-emoji](https://github.com/janlelis/unicode-emoji))

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/acts_as_reactable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/acts_as_reactable/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActsAsReactable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/acts_as_reactable/blob/main/CODE_OF_CONDUCT.md).
