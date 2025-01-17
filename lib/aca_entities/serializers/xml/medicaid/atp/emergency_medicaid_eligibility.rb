# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an assessment of a person's suitability to participate in an emergency Medicaid program based on various criteria.
          class EmergencyMedicaidEligibility
            include HappyMapper

            tag 'EmergencyMedicaidEligibility'
            namespace 'hix-ee'

            attribute :id, String, namespace: "niem-s"

            # A basis for emergency Medicaid eligibility based on residency rules.
            has_one :residency_eligibility_basis, EmergencyMedicaidResidencyEligibilityBasis

            # A basis for emergency Medicaid eligibility based on income rules.
            has_one :income_eligibility_basis, EmergencyMedicaidIncomeEligibilityBasis

            # A basis for emergency Medicaid eligibility based on Medicaid citizen or immigrant rules.
            has_many :citizen_or_immigrant_eligibility_basis, EmergencyMedicaidCitizenOrImmigrantEligibilityBasis

            has_one :eligibility_date_range, EligibilityDateRange

            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(emergency_medicaid_eligibility)
              mapper = self.new
              mapper.id = emergency_medicaid_eligibility.id
              mapper.residency_eligibility_basis = emergency_medicaid_eligibility.residency_eligibility_basis
              mapper.income_eligibility_basis = emergency_medicaid_eligibility.income_eligibility_basis
              mapper.citizen_or_immigrant_eligibility_basis = emergency_medicaid_eligibility.citizen_or_immigrant_eligibility_basis
              mapper.eligibility_date_range = emergency_medicaid_eligibility.eligibility_date_range
              mapper.eligibility_establishing_system = emergency_medicaid_eligibility.eligibility_establishing_system
              mapper
            end

            def to_hash
              {
                residency_eligibility_basis: residency_eligibility_basis&.to_hash,
                income_eligibility_basis: income_eligibility_basis&.to_hash,
                citizen_or_immigrant_eligibility_basis: citizen_or_immigrant_eligibility_basis.map(&:to_hash),
                eligibility_date_range: eligibility_date_range&.to_hash,
                eligibility_establishing_system: eligibility_establishing_system&.to_hash
              }
            end
          end
        end
      end
    end
  end
end