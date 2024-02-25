# frozen_string_literal: true

class TestValidator
  def initialize(value)
    @value = value
  end

  def valid?
    @value == '11144477735'
  end
end
