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
      validator_class = ValidatesIdentity.get_validator(identity_type, type: options[:only])

      return false if validator_class.nil?

      @validator = validator_class.new(value)
      @validator.valid?
    end

    def formatted
      return if @validator.nil?

      if options[:format]
        @validator.formatted
      else
        value
      end
    end

    private

    def identity_type
      if [:person, :legal, nil].include?(options[:only])
        record.send(options[:identity_type]).to_sym
      else
        options[:only]
      end
    rescue NoMethodError
      message = "The attribute #{options[:identity_type]} is not defined in the model #{record.class}"
      ActiveSupport::Logger.new($stdout).debug(message)
      :invalid
    end
  end
end
