# frozen_string_literal: true

class TestValidator
  def initialize(value, options)
    @value = value
    @options = options
  end

  def valid?
    @value == '11144477735'
  end
end
