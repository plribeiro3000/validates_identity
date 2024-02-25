# frozen_string_literal: true

require 'active_model'
require 'identity_validator'

class ValidatesIdentity
  autoload :Identity, 'validates_identity/identity'

  class << self
    private

    def identity_types
      @identity_types ||= {}
    end

    def identity_type_aliases
      @identity_type_aliases ||= {}
    end
  end

  def self.register_identity_type(identity_type_acronym, identity_type_validator)
    identity_types[identity_type_acronym] = identity_type_validator
    identity_type_aliases[identity_type_acronym] = identity_type_acronym
  end

  def self.register_identity_type_alias(identity_type, identity_type_alias)
    identity_type_aliases[identity_type_alias] = identity_type
  end

  def self.get_validator(identity_type)
    identity_alias = identity_type_aliases[identity_type]
    identity_types[identity_alias]
  end
end
