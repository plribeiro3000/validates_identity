# frozen_string_literal: true

class User
  include ActiveModel::Model

  attr_accessor :identity, :identity_type

  validates :identity, identity: { identity_type: :identity_type }
end
