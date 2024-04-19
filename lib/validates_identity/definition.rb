# frozen_string_literal: true

class ValidatesIdentity
  class Definition
    attr_reader :identity_type, :only

    def initialize(identity_type, only)
      @identity_type = identity_type
      @only = only.present? ? only.to_sym : nil
    end

    def valid?
      if identity_type.present? && [:person, :legal, nil].include?(only)
        true
      else
        identity_type.blank? && ValidatesIdentity.send(:identity_type_aliases).keys.include?(only)
      end
    end
  end
end
