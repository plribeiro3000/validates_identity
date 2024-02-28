# frozen_string_literal: true

require 'spec_helper'
require 'shoulda/matchers/active_model/require_a_valid_identity_matcher'

RSpec.describe Shoulda::Matchers::ActiveModel::RequireAValidIdentityMatcher do
  subject { User.new }

  before do
    ValidatesIdentity.register_person_identity_type('Test', TestValidator)
    ValidatesIdentity::ShouldaMatchers.register_person_allowed_values('Test', ['11144477735'])
    ValidatesIdentity::ShouldaMatchers.register_person_disallowed_values('Test', ['123'])
  end

  it { is_expected.to require_a_valid_identity(:identity, :identity_type) }
  it { is_expected.to require_a_valid_identity }
  it { is_expected.to require_a_valid_identity(:legal_identity, :legal_identity_type, only: :legal) }
  it { is_expected.to require_a_valid_identity(:person_identity, :person_identity_type, only: :person) }
  it { is_expected.not_to require_a_valid_identity(:name, :identity_type) }
end
