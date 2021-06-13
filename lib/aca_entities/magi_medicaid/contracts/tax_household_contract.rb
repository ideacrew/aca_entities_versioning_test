# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::TaxHousehold}
      class TaxHouseholdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Float] :max_aptc optional
        # @option opts [String] :is_insurance_assistance_eligible optional
        # @option opts [Array] :tax_household_members optional
        # @return [Dry::Monads::Result]
        params do
          optional(:max_aptc).maybe(Types::Money)
          required(:hbx_id).filled(:string)
          optional(:is_insurance_assistance_eligible).maybe(Types::IaEligibilityKind)
          required(:tax_household_members).array(TaxHouseholdMemberContract.params)

          optional(:annual_tax_household_income).maybe(Types::Money)

          optional(:effective_on).maybe(:date)
        end
      end
    end
  end
end
