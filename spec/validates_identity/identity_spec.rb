# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity::Identity do
  let(:user) { User.new }

  it 'accepts nil value' do
    expect(described_class.new(user, nil, {})).to be_valid
  end

  it 'accepts blank value' do
    expect(described_class.new(user, '', {})).to be_valid
  end

  it 'rejects if identity type is not defined' do
    expect(described_class.new(user, '11144477735', {})).not_to be_valid
  end

  it 'rejects if identity type is nil' do
    expect(described_class.new(user, '11144477735', { identity_type: nil })).not_to be_valid
  end

  it 'rejects if identity type is blank' do
    expect(described_class.new(user, '11144477735', { identity_type: '' })).not_to be_valid
  end

  it 'rejects if identity type is not registered' do
    expect(described_class.new(user, '11144477735', { identity_type: :abc_validator })).not_to be_valid
  end

  context 'with a validator registered' do
    before do
      ValidatesIdentity.register_identity_type('Test', TestValidator)
      user.identity_type = 'Test'
    end

    it 'uses the validator defined' do
      expect(described_class.new(user, '11144477735', identity_type: :identity_type)).to be_valid
    end
  end

  context 'with an alias for a registered validator' do
    before do
      ValidatesIdentity.register_identity_type('Test', TestValidator)
      ValidatesIdentity.register_identity_type_alias('Test', 'Alias')
      user.identity_type = 'Alias'
    end

    it 'uses the validator defined' do
      expect(described_class.new(user, '11144477735', identity_type: :identity_type)).to be_valid
    end
  end
end
