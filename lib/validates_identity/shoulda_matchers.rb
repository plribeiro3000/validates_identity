# frozen_string_literal: true

class ValidatesIdentity
  class ShouldaMatchers
    class << self
      def person_allowed_values
        @person_allowed_values ||= {}
      end

      def legal_allowed_values
        @legal_allowed_values ||= {}
      end

      def person_disallowed_values
        @person_disallowed_values ||= {}
      end

      def legal_disallowed_values
        @legal_disallowed_values ||= {}
      end

      def allowed_values
        person_allowed_values.merge(legal_allowed_values)
      end

      def disallowed_values
        person_disallowed_values.merge(legal_disallowed_values)
      end

      def register_person_allowed_values(identity_type_acronym, values = [])
        person_allowed_values[identity_type_acronym] = values
      end

      def register_legal_allowed_values(identity_type_acronym, values = [])
        legal_allowed_values[identity_type_acronym] = values
      end

      def register_person_disallowed_values(identity_type_acronym, values = [])
        person_disallowed_values[identity_type_acronym] = values
      end

      def register_legal_disallowed_values(identity_type_acronym, values = [])
        legal_disallowed_values[identity_type_acronym] = values
      end
    end
  end
end
