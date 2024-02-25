# frozen_string_literal: true

module ValidatesIdentity
  class Identity
    attr_reader :record, :value, :options

    def initialize(record, value, options)
      @record = record
      @value = value
      @options = options
    end

    def valid?
      return true if value.blank?
      return false if options[:identity_type].blank?

      validator_class = ValidatesIdentity.get_validator(identity_type)

      return false if validator_class.nil?

      validator = validator_class.new(value, options)
      validator.valid?
    end

    private

    def identity_type
      record.send(options[:identity_type])
    rescue NoMethodError
      :invalid
    end
  end
end
