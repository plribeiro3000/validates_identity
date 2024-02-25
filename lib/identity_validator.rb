# frozen_string_literal: true

class IdentityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    identity = ValidatesIdentity::Identity.new(record, value, options)

    return if identity.valid?

    ruby_prior_version_three =
      Gem::Version.new(RUBY_VERSION) < Gem::Version.new('3.0.0')

    if ruby_prior_version_three
      record.errors.add(attribute, :invalid, options)
    else
      record.errors.add(attribute, :invalid, **options)
    end
  end
end
