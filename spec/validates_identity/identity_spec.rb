# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity::Identity do
  let(:user) { User.new }

  before { ValidatesIdentity.register_person_identity_type('Test', TestValidator) }

  it 'accepts nil value' do
    expect(described_class.new(user, :identity, nil, {})).to be_valid
  end

  it 'accepts blank value' do
    expect(described_class.new(user, :identity, '', {})).to be_valid
  end

  it 'accepts if identity type is not defined and only is a valid key' do
    expect(described_class.new(user, :unique_identity, '11144477735', only: 'Test')).to be_valid
  end

  it 'rejects if identity type is not a valid attribute' do
    expect(described_class.new(user, :invalid_identity, '11144477735', {})).not_to be_valid
  end

  it 'rejects if identity type and only are not defined' do
    expect(described_class.new(user, :identity, '11144477735', {})).not_to be_valid
  end

  it 'rejects if identity type is nil and only is nil' do
    expect(described_class.new(user, :identity, '11144477735', { identity_type: nil, only: nil })).not_to be_valid
  end

  it 'rejects if identity type is nil and options is not defined' do
    expect(described_class.new(user, :identity, '11144477735', { identity_type: nil })).not_to be_valid
  end

  it 'rejects if identity type is not defined and only is nil' do
    expect(described_class.new(user, :identity, '11144477735', { only: nil })).not_to be_valid
  end

  it 'rejects if identity type is blank and only is blank' do
    expect(described_class.new(user, :identity, '11144477735', { identity_type: '', only: '' })).not_to be_valid
  end

  it 'rejects if identity type is blank and only is not defined' do
    expect(described_class.new(user, :identity, '11144477735', { identity_type: '' })).not_to be_valid
  end

  it 'rejects if identity type is not defined and only is blank' do
    expect(described_class.new(user, :identity, '11144477735', { only: '' })).not_to be_valid
  end

  it 'rejects if identity type is not defined and only is legal' do
    expect(described_class.new(user, :identity, '11144477735', { only: :legal })).not_to be_valid
  end

  it 'rejects if identity type is not defined and only is person' do
    expect(described_class.new(user, :identity, '11144477735', { only: :person })).not_to be_valid
  end

  it 'rejects if identity type is not registered' do
    expect(described_class.new(user, :identity, '11144477735', { identity_type: :abc_validator })).not_to be_valid
  end

  it 'rejects if identity type is not defined and only is an invalid key' do
    expect(described_class.new(user, :unique_identity, '11144477735', only: 'Abc')).not_to be_valid
  end

  context 'with a validator registered' do
    before do
      user.identity_type = 'Test'
    end

    it 'uses the validator defined' do
      expect(described_class.new(user, :identity, '11144477735', identity_type: :identity_type)).to be_valid
    end
  end

  context 'with an alias for a registered validator' do
    before do
      ValidatesIdentity.register_person_identity_type_alias('Test', 'Alias')
      user.identity_type = 'Alias'
    end

    it 'uses the validator defined' do
      expect(described_class.new(user, :identity, '11144477735', identity_type: :identity_type)).to be_valid
    end
  end
end
