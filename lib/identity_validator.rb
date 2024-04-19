# frozen_string_literal: true

class IdentityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if value.blank?

    identity = ValidatesIdentity::Identity.new(record, attribute, value, options)

    if definition.valid? && identity.valid?
      record.send("#{attribute}=", identity.formatted)
    elsif ruby_prior_version_three
      record.errors.add(attribute, :invalid, options)
    else
      record.errors.add(attribute, :invalid, **options)
    end
  end

  private

  def ruby_prior_version_three
    Gem::Version.new(RUBY_VERSION) < Gem::Version.new('3.0.0')
  end

  def definition
    @definition ||= ValidatesIdentity::Definition.new(
      options[:identity_type],
      options[:only]
    )
  end
end
