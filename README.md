# ActsAsReactable

![build](https://github.com/public-reactions/acts_as_reactable/actions/workflows/main.yml/badge.svg)
[![codecov](https://codecov.io/gh/public-reactions/acts_as_reactable/branch/main/graph/badge.svg?token=OVDCJIQAFN)](https://codecov.io/gh/public-reactions/acts_as_reactable)
[![Gem Version](https://badge.fury.io/rb/acts_as_reactable.svg)](https://badge.fury.io/rb/acts_as_reactable)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add acts_as_reactable

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install acts_as_reactable

## Usage

### 1. create the Reaction model

```ruby
# with default bigint id
create_table :reactions do |t|
  t.references :reactable, polymorphic: true, null: false
  t.references :reactor, polymorphic: true, null: false

  t.string :emoji, null: false, index: true

  t.timestamps
end

# with uuid id
create_table :reactions do |t|
  t.references :reactable, polymorphic: true, type: :uuid, null: false
  t.references :reactor, polymorphic: true, type: :uuid, null: false

  t.string :emoji, null: false, index: true

  t.timestamps
end
```

### 2. annotate reactable and reactor models

```ruby
# reactable
class Post < ApplicationRecord
  acts_as_reactable
end

# reactor
class User < ApplicationRecord
  acts_as_reactor
end
```

### 3. creating/updating reactions

```ruby
reaction = post.update_reaction_from(user, "😀")
```

### 4. deleting reactions

```ruby
post.destroy_reaction_from(user) # returns value like #destroy in ActiveRecord

# #update_reaction_from with a nil reaction also delete the reaction
post.update_reaction_from(user)
```

### 5. private opinion from one reactor

```ruby
reaction = ActsAsReactable::Reaction.find_by(reactable: self, reactor: user)&.emoji
```

### 6. group, count and sort to get a summary of public opinion

```ruby
ActsAsReactable::Reaction.where(reactable: reactor).group(:emoji).order('count_id DESC').count(:id)

# { "😀": 10, "😢": 5, "😣": 1 }
```

## FAQ

### Why saving the emoji character instead of "smily_face"

- Technically, there's no concrete name/key/id for emoji (and modifiers like skin tone). The [CLDR short names](https://unicode.org/emoji/format.html#col-name) "vary by language" and "may change", besides, are those names case sensitive? Should we use `-`, `_` or ` ` as divider? How to append tone variant? There are several error prone decisions to make.
- It's easier to store since all modern database supports encodings (e.g. UTF-8) for unicode characters.
- It's easy to validate with libs/regex (e.g. [unicode-emoji](https://github.com/janlelis/unicode-emoji)).
- It takes less size on disk to store (and presumably less time to index/sort/match) one unicode character 😂 (4 bytes) than `face with tears of joy` (22 bytes). [This is a great article to explain how utf-8 works](https://sethmlarson.dev/blog/utf-8)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/acts_as_reactable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/acts_as_reactable/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActsAsReactable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/acts_as_reactable/blob/main/CODE_OF_CONDUCT.md).
