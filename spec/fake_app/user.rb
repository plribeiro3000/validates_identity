# frozen_string_literal: true

class User
  include ActiveModel::Model

  attr_accessor :identity, :identity_type, :legal_identity, :legal_identity_type, :legal_formatted_identity, :name,
                :person_identity, :person_identity_type, :person_formatted_identity

  validates :identity, identity: { identity_type: :identity_type }
  validates :legal_identity, identity: { identity_type: :legal_identity_type, only: :legal }
  validates :legal_formatted_identity, identity: { identity_type: :legal_identity_type, only: :legal, format: true }
  validates :person_identity, identity: { identity_type: :person_identity_type, only: :person }
  validates :person_formatted_identity, identity: { identity_type: :person_identity_type, only: :person, format: true }
end
