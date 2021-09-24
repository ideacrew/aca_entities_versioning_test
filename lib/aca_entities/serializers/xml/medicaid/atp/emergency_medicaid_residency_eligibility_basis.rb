# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for emergency Medicaid eligibility based on residency rules.
          class EmergencyMedicaidResidencyEligibilityBasis
            include HappyMapper

            tag 'EmergencyMedicaidResidencyEligibilityBasis'
            namespace 'hix-ee'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"

            def self.domain_to_mapper(eligibility_basis)
              mapper = self.new
              mapper.status_indicator = eligibility_basis.status_indicator
              mapper.status_code = eligibility_basis.status_code
              mapper
            end

            def to_hash
              {
                status_indicator: status_indicator,
                status_code: status_code
              }
            end
          end
        end
      end
    end
  end
end