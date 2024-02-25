# frozen_string_literal: true

class ValidatesIdentity
  class ShouldaMatchers
    class << self
      def allowed_values
        @allowed_values ||= {}
      end

      def disallowed_values
        @disallowed_values ||= {}
      end

      def register_allowed_values(identity_type_acronym, values = [])
        allowed_values[identity_type_acronym] = values
      end

      def register_disallowed_values(identity_type_acronym, values = [])
        disallowed_values[identity_type_acronym] = values
      end
    end
  end
end
