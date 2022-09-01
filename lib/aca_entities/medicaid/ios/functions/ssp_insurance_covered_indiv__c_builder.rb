# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_InsuranceCoveredIndiv__c for IOS transform
        class SspInsuranceCoveredIndivCBuilder
          def call(cache)
            @memoized_data = cache
            # TO DO
            # loop through applicants
            # build hash of field mappings
            # return array of transformed SSP_InsuranceCoveredIndiv__c hashes
            [] # mocked return array for initial spec
          end
        end
      end
    end
  end
end