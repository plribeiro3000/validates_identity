# frozen_string_literal: true

require 'active_model'
require 'identity_validator'

class ValidatesIdentity
  autoload :Definition, 'validates_identity/definition'
  autoload :Identity, 'validates_identity/identity'
  autoload :ShouldaMatchers, 'validates_identity/shoulda_matchers'

  class << self
    private

    def person_identity_types
      @person_identity_types ||= {}
    end

    def legal_identity_types
      @legal_identity_types ||= {}
    end

    def identity_types
      person_identity_types.merge(legal_identity_types)
    end

    def person_normalizers
      @person_normalizers ||= {}
    end

    def legal_normalizers
      @legal_normalizers ||= {}
    end

    def normalizers
      person_normalizers.merge(legal_normalizers)
    end

    def person_identity_type_aliases
      @person_identity_type_aliases ||= {}
    end

    def legal_identity_type_aliases
      @legal_identity_type_aliases ||= {}
    end

    def identity_type_aliases
      person_identity_type_aliases.merge(legal_identity_type_aliases)
    end
  end

  def self.register_person_identity_type(identity_type_acronym, identity_type_validator, normalize: nil)
    person_identity_types[identity_type_acronym.to_sym] = identity_type_validator
    person_normalizers[identity_type_acronym.to_sym] = normalize
    register_person_identity_type_alias(identity_type_acronym, identity_type_acronym)
  end

  def self.register_legal_identity_type(identity_type_acronym, identity_type_validator, normalize: nil)
    legal_identity_types[identity_type_acronym.to_sym] = identity_type_validator
    legal_normalizers[identity_type_acronym.to_sym] = normalize
    register_legal_identity_type_alias(identity_type_acronym, identity_type_acronym)
  end

  def self.register_person_identity_type_alias(identity_type, identity_type_alias)
    person_identity_type_aliases[identity_type_alias.to_sym] = identity_type.to_sym
  end

  def self.register_legal_identity_type_alias(identity_type, identity_type_alias)
    legal_identity_type_aliases[identity_type_alias.to_sym] = identity_type.to_sym
  end

  def self.get_validator(identity_type, type: :both)
    identity_alias =
      case type
      when :person then person_identity_type_aliases[identity_type.to_sym]
      when :legal then legal_identity_type_aliases[identity_type.to_sym]
      else identity_type_aliases[identity_type.to_sym]
      end

    identity_types[identity_alias]
  end

  def self.get_normalizer(identity_type, type: :both)
    identity_alias =
      case type
      when :person then person_identity_type_aliases[identity_type.to_sym]
      when :legal then legal_identity_type_aliases[identity_type.to_sym]
      else identity_type_aliases[identity_type.to_sym]
      end

    normalizers[identity_alias]
  end
end
