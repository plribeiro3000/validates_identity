# frozen_string_literal: true

class ValidatesIdentity
  class Usage
    attr_reader :identity_type, :only

    def initialize(identity_type, only)
      @identity_type = identity_type
      @only = only
    end

    def valid?
      return false if identity_type.blank? && only.blank?
      return false if identity_type.blank? && %i[person legal].include?(only)

      identity_type.blank? || [:person, :legal, nil].include?(only)
    end
  end
end
