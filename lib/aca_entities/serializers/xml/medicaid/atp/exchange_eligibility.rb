# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An assessment of a person's suitability to participate in an exchange eligibility program
          class ExchangeEligibility
            include HappyMapper

            tag 'ExchangeEligibility'
            namespace 'hix-ee'

            has_one :eligibility_date_range, EligibilityDateRange
            has_one :eligibility_establishing_system, EligibilityEstablishingSystem

            def self.domain_to_mapper(exchange_eligibility)
              mapper = self.new
              mapper.eligibility_date_range = exchange_eligibility.eligibility_date_range
              mapper.eligibility_establishing_system = exchange_eligibility.eligibility_establishing_system
              mapper
            end

            def to_hash
              {
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