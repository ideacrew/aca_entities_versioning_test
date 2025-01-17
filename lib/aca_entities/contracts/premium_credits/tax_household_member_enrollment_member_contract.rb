# frozen_string_literal: true

module AcaEntities
  module Contracts
    module PremiumCredits
      # Schema and validation rules for {AcaEntities::PremiumCredits::TaxHouseholdEnrollmentMember}
      class TaxHouseholdMemberEnrollmentMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :hbx_enrollment_member_id required
        # @option opts [Hash] :tax_household_member_id required
        # @option opts [Hash] :member_ehb_benchmark_health_premium optional
        # @option opts [Hash] :member_ehb_benchmark_dental_premium optional
        # @option opts [String] :age_on_effective_date required
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_enrollment_member).hash(AcaEntities::Contracts::Enrollments::HbxEnrollmentMemberContract.params)
          required(:tax_household_member).hash(AcaEntities::Contracts::Households::TaxHouseholdMemberContract.params)
          required(:age_on_effective_date).maybe(:integer)
          required(:family_member_reference).hash(AcaEntities::Contracts::Families::FamilyMemberReferenceContract.params)
          required(:relationship_with_primary).maybe(:string)
          required(:date_of_birth).maybe(:date)
        end
      end
    end
  end
end
