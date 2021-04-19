# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Application}
      class ApplicationContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :family_reference required
        # @option opts [Integer] :assistance_year required
        # @option opts [Integer] :years_to_renew optional
        # @option opts [Integer] :renewal_consent_through_year optional
        # @option opts [Boolean] :is_ridp_verified optional
        # @option opts [Boolean] :is_renewal_authorized optional
        # @option opts [Array] :applicants required
        # @return [Dry::Monads::Result]
        params do
          required(:family_reference).hash(::AcaEntities::Contracts::Families::FamilyReferenceContract.params)
          required(:assistance_year).filled(:integer)
          optional(:years_to_renew).maybe(:integer)
          optional(:renewal_consent_through_year).maybe(:integer)
          optional(:is_ridp_verified).maybe(:bool)
          optional(:is_renewal_authorized).maybe(:bool)
          required(:applicants).array(ApplicantContract.params)
          optional(:relationships).array(RelationshipContract.params)
          optional(:tax_households).array(TaxHouseholdContract.params)
        end
      end
    end
  end
end
