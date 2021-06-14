# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # SecondaryRequest.
          class SecondaryRequest
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            tag 'SecondaryRequest'
            namespace 'ext'

            element :SessionIdentification, String, tag: 'SessionIdentification'
            has_one :verification_answer_set, VerificationAnswerSet

            def self.domain_to_mapper(secondary_response)
              mapper = self.new
              mapper.verification_answer_set = VerificationAnswerSet.domain_to_mapper(secondary_response.verification_answer_set)
              mapper
            end
          end
        end
      end
    end
  end
end