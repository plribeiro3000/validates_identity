# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity do
  describe '.register_identity_type' do
    before do
      described_class.register_identity_type('Test', TestValidator)
    end

    it 'defines identity type' do
      expect(described_class.send(:identity_types)).to eq('Test' => TestValidator)
    end

    it 'defines an alias' do
      expect(described_class.send(:identity_type_aliases)).to eq('Test' => 'Test')
    end
  end

  describe '.register_identity_type_alias' do
    before do
      described_class.register_identity_type('Test', TestValidator)
      described_class.register_identity_type_alias('Test', 'T')
    end

    it 'defines an alias' do
      expect(described_class.send(:identity_type_aliases)['T']).to eq('Test')
    end
  end

  describe '.get_validator' do
    before do
      described_class.register_identity_type('Test', TestValidator)
      described_class.register_identity_type_alias('Test', 'T')
    end

    it 'returns validator' do
      expect(described_class.get_validator('Test')).to eq(TestValidator)
    end

    it 'returns validator for alias' do
      expect(described_class.get_validator('T')).to eq(TestValidator)
    end
  end
end
