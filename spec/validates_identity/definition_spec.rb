# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity::Definition do
  before { ValidatesIdentity.register_person_identity_type('Test', TestValidator) }

  it 'accepts if identity type is present and only is blank' do
    expect(described_class.new('test', nil)).to be_valid
  end

  it 'accepts if identity type is present and only is person' do
    expect(described_class.new('test', :person)).to be_valid
  end

  it 'accepts if identity type is present and only is legal' do
    expect(described_class.new('test', :legal)).to be_valid
  end

  it 'rejects if identity type is nil and only is nil' do
    expect(described_class.new(nil, nil)).not_to be_valid
  end

  it 'rejects if identity type is blank and only is blank' do
    expect(described_class.new('', '')).not_to be_valid
  end

  it 'rejects if identity type is blank and only is legal' do
    expect(described_class.new('', :legal)).not_to be_valid
  end

  it 'rejects if identity type is blank and only is person' do
    expect(described_class.new('', :person)).not_to be_valid
  end

  it 'rejects if identity type is nil and only is legal' do
    expect(described_class.new(nil, :legal)).not_to be_valid
  end

  it 'rejects if identity type is nil and only is person' do
    expect(described_class.new(nil, :person)).not_to be_valid
  end

  it 'rejects if identity type is present and only is a specific document type' do
    expect(described_class.new('test', 'test')).not_to be_valid
  end

  it 'accepts if identity type is blank and only is a specific document type' do
    expect(described_class.new(nil, 'Test')).to be_valid
  end
end
