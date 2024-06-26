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
- [Brazil CPF](https://github.com/plribeiro3000/validates_identity-br_cpf)
- [Brazil CNPJ](https://github.com/plribeiro3000/validates_identity-br_cnpj)
- [Chile RUT](https://github.com/plribeiro3000/validates_identity-cl_rut)
- [Colombia CC](https://github.com/plribeiro3000/validates_identity-co_cc)
- [Colombia NIT](https://github.com/JonatascNascimento/validates_identity-co_nit)
- [Guatemala DPI](https://github.com/plribeiro3000/validates_identity-gt_dpi)
- [Panama RUC](https://github.com/plribeiro3000/validates_identity-pa_ruc)
- [Peru DNI](https://github.com/plribeiro3000/validates_identity-pe_dni)
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
  validates :identity, identity: { only: 'MX_RFC_PERSON' }
end
```

#### Person

One of the options that `only` accept is `:person`.
This will tell the validator to only accept individual type documents and reject legal type documents

```ruby
class User < ActiveRecord::Base
  # will accept only person identity types
  validates :identity, identity: { identity_type: :identity_type, only: :person }
end
```

#### Legal

One of the options that `only` accept is `:legal`.
This will tell the validator to only accept legal type documents and reject individual type documents

```ruby
class User < ActiveRecord::Base
  # will accept only legal identity types
  validates :identity, identity: { identity_type: :identity_type, only: :legal }
end
```

#### Specific Document Type

Another option that `only` accept is a unique document registration key.
This will tell the validtor to only accept this document type and reject any other one

```ruby
class User < ActiveRecord::Base
  # will accept only Argentina DNI
  validates :identity, identity: { only: 'AR_DNI' }
end
```

Note that when using this scenarion it is not necessary neither accepted to define the secondary column through `identity_type`.

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
