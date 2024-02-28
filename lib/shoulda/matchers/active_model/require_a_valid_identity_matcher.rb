# frozen_string_literal: true

require 'shoulda-matchers'

module Shoulda
  module Matchers
    module ActiveModel
      def require_a_valid_identity(identity = :identity, identity_type = :identity_type, only: :both)
        RequireAValidIdentityMatcher.new(identity, identity_type, only)
      end

      class RequireAValidIdentityMatcher < ValidationMatcher
        def initialize(identity, identity_type, type)
          super(identity)
          @identity_type = identity_type
          @type = type
        end

        def description
          case @type
          when :person then 'require a valid person identity'
          when :legal then 'require a valid legal identity'
          else 'require a valid identity'
          end
        end

        def failure_message
          case @type
          when :person then 'does not require a valid person identity'
          when :legal then 'does not require a valid legal identity'
          else 'expected to require a valid identity'
          end
        end

        def matches?(subject)
          super(subject)

          result = []

          allowed_values.each do |identity_type, values|
            subject.send("#{@identity_type}=", identity_type)

            values.each do |value|
              result << allows_value_of(value)
            end
          end

          disallowed_values.each do |identity_type, values|
            subject.send("#{@identity_type}=", identity_type)

            values.each do |value|
              result << disallows_value_of(value)
            end
          end

          result.inject(:&)
        end

        private

        def allowed_values
          case @type
          when :person then person_allowed_values
          when :legal then legal_allowed_values
          else ValidatesIdentity::ShouldaMatchers.allowed_values
          end
        end

        def disallowed_values
          case @type
          when :person then person_disallowed_values.deep_merge(legal_allowed_values)
          when :legal then legal_disallowed_values.deep_merge(person_allowed_values)
          else ValidatesIdentity::ShouldaMatchers.disallowed_values
          end
        end

        def person_allowed_values
          ValidatesIdentity::ShouldaMatchers.person_allowed_values
        end

        def person_disallowed_values
          ValidatesIdentity::ShouldaMatchers.person_disallowed_values
        end

        def legal_allowed_values
          ValidatesIdentity::ShouldaMatchers.legal_allowed_values
        end

        def legal_disallowed_values
          ValidatesIdentity::ShouldaMatchers.legal_disallowed_values
        end
      end
    end
  end
end
