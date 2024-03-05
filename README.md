# ValidatesIdentity

This projects aims to validate several countries person identification documents.
It works on top of 2 attributes, so that the identity can be determined by a second value and thus validate the first one accordingly

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validates_identity'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install validates_identity

## Official Plugins

Just require the plugins you want/need in your Gemfile and you will be good to go

- [Argentina DNI](https://github.com/plribeiro3000/validates_identity-ar_dni)
- [Brazilian CPF](https://github.com/plribeiro3000/validates_identity-br_cpf)
- [Brazilian CNPJ](https://github.com/plribeiro3000/validates_identity-br_cnpj)
- [Guatemala DPI](https://github.com/plribeiro3000/validates_identity-gt_dpi)
- [Panama RUC](https://github.com/plribeiro3000/validates_identity-pa_ruc)
- [Peru RUC](https://github.com/plribeiro3000/validates_identity-pe_ruc)
- [Mexico RFC](https://github.com/plribeiro3000/validates_identity-mx_rfc)

## Usage

Just use as any other validator:

```ruby
class User < ActiveRecord::Base
  # :identity_type is the attribute that will be used to determine the identity type and is required
  validates :identity, identity: { identity_type: :identity_type }
end
```

### Format Option

The `format` option can be used to format the final identity value.

```ruby
class User < ActiveRecord::Base
  # all values will be formatted after successful validation
  validates :identity, identity: { identity_type: :identity_type, format: true }
end
```

### Only Option

The `only` option can be used to narrow down the validators

```ruby
class User < ActiveRecord::Base
  # will accept only person identity types
  validates :identity, identity: { identity_type: :identity_type, only: :person }
  # will accept only legal identity types
  validates :identity, identity: { identity_type: :identity_type, only: :legal }
end
```

### Aliases

In case of a legacy system where keys were already defined and differ from the official ones, aliases can be registered to easy the transition

```ruby
ValidatesIdentity.register_person_identity_type_alias('LegacyIdentity', 'CustomIdentity')
ValidatesIdentity.register_legal_identity_type_alias('LegacyIdentity', 'CustomIdentity')
```

### Adding your own Validators

New Identity Validators can be registered through the public apis of `ValidatesIdentity`

```ruby
ValidatesIdentity.register_person_identity_type('CustomIdentity', CustomIdentityValidator)
ValidatesIdentity.register_legal_identity_type('CustomIdentity', CustomIdentityValidator)
```

A Validator must implement:

- a constructor with 1 param: `value`
- a `valid?` method that returns a boolean
- a `formatted` method that returns the formatted value

### Adding scenarios to the matcher

When adding a new validator, cases of success and error can be added through and API so that the `Matcher` will test against them

```ruby
ValidatesIdentity::ShouldaMatchers.register_allowed_values('CustomIdentity', ['123456789', '123.456.789'])
ValidatesIdentity::ShouldaMatchers.register_disallowed_values('CustomIdentity', ['12345679', '12.456.789'])
```

## Testing

Require matcher in your `spec_helper` or `rails_helper` file:

```ruby
require 'shoulda/matchers/active_model/require_a_valid_identity_matcher'
```

Use in your tests:

```ruby
it { is_expected.to require_a_valid_identity } # It will test the attributes :identity and :identity_type by default
it { is_expected.to require_a_valid_identity(:id, :my_type) }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/plribeiro3000/validates_identity. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/plribeiro3000/validates_identity/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ValidatesIdentity project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/plribeiro3000/validates_identity/blob/master/CODE_OF_CONDUCT.md).
