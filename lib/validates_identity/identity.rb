# frozen_string_literal: true

class ValidatesIdentity
  class Identity
    attr_reader :record, :attribute, :value, :options

    def initialize(record, attribute, value, options)
      @record = record
      @attribute = attribute
      @value = value
      @options = options
    end

    def valid?
      return true if value.blank?
      return false if options[:identity_type].blank?

      validator_class = ValidatesIdentity.get_validator(identity_type, type: options[:only])

      return false if validator_class.nil?

      @validator = validator_class.new(value)
      @validator.valid?
    end

    def formatted
      return if @validator.nil?

      @validator.formatted
    end

    private

    def identity_type
      record.send(options[:identity_type])
    rescue NoMethodError
      :invalid
    end
  end
end
