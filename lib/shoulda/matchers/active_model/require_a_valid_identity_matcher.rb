# frozen_string_literal: true

require 'shoulda-matchers'

module Shoulda
  module Matchers
    module ActiveModel
      def require_a_valid_identity(identity = :identity, identity_type = :identity_type)
        RequireAValidIdentityMatcher.new(identity, identity_type)
      end

      class RequireAValidIdentityMatcher < ValidationMatcher
        def initialize(identity, identity_type)
          super(identity)
          @identity_type = identity_type
        end

        def description
          'requires a valid identity'
        end

        def failure_message
          'does not require a valid identity'
        end

        def matches?(subject)
          super(subject)

          result = []

          ValidatesIdentity::ShouldaMatchers.allowed_values.each do |identity_type, values|
            subject.send("#{@identity_type}=", identity_type)

            values.each do |value|
              result << allows_value_of(value)
            end
          end

          ValidatesIdentity::ShouldaMatchers.disallowed_values.each do |identity_type, values|
            subject.send("#{@identity_type}=", identity_type)

            values.each do |value|
              result << disallows_value_of(value)
            end
          end

          result.inject(:&)
        end
      end
    end
  end
end
