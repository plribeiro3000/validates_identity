# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity::Usage do
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
end
