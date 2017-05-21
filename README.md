# Ruboty::Mastodon
A [Ruboty](https://github.com/r7kamura/ruboty) adapter, which reacts to Mastodon Mention.

## Usage

Add these line to your ruboty's Gemfile:

```ruby
gem 'mastodon-api', git: 'https://github.com/tootsuite/mastodon-api', ref: '39f4b0354f3c15075d16e9a810d695824a230b0b'
gem 'ruboty-mastodon', git: 'https://github.com/en30/ruboty-mastodon'
```

Note that you have to add mastodon-api to your Gemfile.
This is because mastodon-api's version which supports streaming API is not yet published to rubygems.org, so I can not add it to ruboty-mastodon's dependency.

## Environment variables

Variable name               | Description             | Example
--------------------------- | ----------------------- | -----------------
`MASTODON_URL`              | Mastodon url            | http://localhost:3000
`MASTODON_STREAMING_URL`    | Mastodon strewaming url (default: MASTODON_URL) | http://localhost:4000
`MASTODON_TOKEN`            | Mastodon access token   |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruboty-mastodon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
