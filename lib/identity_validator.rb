# frozen_string_literal: true

class IdentityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    identity = ValidatesIdentity::Identity.new(record, attribute, value, options)

    if usage.valid? && identity.valid?
      record.send("#{attribute}=", identity.formatted)
    else
      ruby_prior_version_three =
        Gem::Version.new(RUBY_VERSION) < Gem::Version.new('3.0.0')

      if ruby_prior_version_three
        record.errors.add(attribute, :invalid, options)
      else
        record.errors.add(attribute, :invalid, **options)
      end
    end
  end

  def usage
    @usage ||= ValidatesIdentity::Usage.new(
      options[:identity_type],
      options[:only]
    )
  end
end
