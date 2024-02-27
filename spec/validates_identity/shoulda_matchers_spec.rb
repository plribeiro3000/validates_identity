# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity::ShouldaMatchers do
  describe '.allowed_values' do
    before do
      described_class.register_person_allowed_values(:cpf, %w[12345678909])
      described_class.register_legal_allowed_values(:cnpj, %w[12345678901234])
    end

    it 'returns the allowed values' do
      expect(described_class.allowed_values).to eq(cpf: %w[12345678909], cnpj: %w[12345678901234])
    end
  end

  describe '.disallowed_values' do
    before do
      described_class.register_person_disallowed_values(:cpf, %w[12345678909])
      described_class.register_legal_disallowed_values(:cnpj, %w[12345678901234])
    end

    it 'returns the disallowed values' do
      expect(described_class.disallowed_values).to eq(cpf: %w[12345678909], cnpj: %w[12345678901234])
    end
  end

  describe '.register_person_allowed_values' do
    before do
      described_class.register_person_allowed_values(:cpf, %w[12345678909])
    end

    it 'register the allowed values for person only type' do
      expect(described_class.send(:person_allowed_values)).to eq(cpf: %w[12345678909])
    end

    it 'register the allowed values for all types' do
      expect(described_class.allowed_values).to eq(cpf: %w[12345678909])
    end
  end

  describe '.register_legal_allowed_values' do
    before do
      described_class.register_legal_allowed_values(:cnpj, %w[12345678901234])
    end

    it 'register the allowed values for legal only type' do
      expect(described_class.send(:legal_allowed_values)).to eq(cnpj: %w[12345678901234])
    end

    it 'register the allowed values for all types' do
      expect(described_class.allowed_values).to eq(cnpj: %w[12345678901234])
    end
  end

  describe '.register_person_disallowed_values' do
    before do
      described_class.register_person_disallowed_values(:cpf, %w[12345678909])
    end

    it 'register the disallowed values for person only type' do
      expect(described_class.send(:person_disallowed_values)).to eq(cpf: %w[12345678909])
    end

    it 'register the disallowed values for all types' do
      expect(described_class.disallowed_values).to eq(cpf: %w[12345678909])
    end
  end

  describe '.register_legal_disallowed_values' do
    before do
      described_class.register_legal_disallowed_values(:cnpj, %w[12345678901234])
    end

    it 'register the disallowed values for legal only type' do
      expect(described_class.send(:legal_disallowed_values)).to eq(cnpj: %w[12345678901234])
    end

    it 'register the disallowed values for all types' do
      expect(described_class.disallowed_values).to eq(cnpj: %w[12345678901234])
    end
  end
end
