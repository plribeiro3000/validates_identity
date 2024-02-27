# frozen_string_literal: true

require 'spec_helper'

RSpec.describe IdentityValidator do
  let(:user) { User.new }

  context 'with invalid identity' do
    before do
      user.identity = '12345'
      user.valid?
    end

    it 'invalidates object' do
      expect(user).not_to be_valid
    end

    it 'sets an error message' do
      expect(user.errors[:identity]).to match(['is invalid'])
    end
  end

  context 'with valid identity' do
    before do
      ValidatesIdentity.register_person_identity_type('Test', TestValidator)
      user.identity = '11144477735'
      user.identity_type = 'Test'
      user.valid?
    end

    it 'validates object' do
      expect(user).to be_valid
    end

    it 'does not set an error message' do
      expect(user.errors[:identity]).to be_blank
    end
  end

  context 'with nil identity' do
    before do
      user.identity = nil
      user.valid?
    end

    it 'validates object' do
      expect(user).to be_valid
    end

    it 'does not set an error message' do
      expect(user.errors[:identity]).to be_blank
    end
  end
end
