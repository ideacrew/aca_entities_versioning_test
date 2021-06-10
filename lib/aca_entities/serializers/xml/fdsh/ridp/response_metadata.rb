# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # ResponseMetadata.
          class ResponseMetadata
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'hix-core:ResponseMetadata'
            namespace 'hix-core'

            element :ResponseCode, String, tag: "ResponseCode", namespace: 'hix-core'
            element :ResponseDescriptionText, String, tag: "ResponseDescriptionText", namespace: 'hix-core'
            element :TDSResponseDescriptionText, String, tag: "TDSResponseDescriptionText", namespace: 'hix-core'

            def self.domain_to_mapper(initial_response)
              mapper = self.new
              mapper.version = "1.0"
              mapper.ResponseCode = initial_response.ResponseCode
              mapper.ResponseDescriptionText = initial_response.response_description_text
              mapper.TDSResponseDescriptionText = initial_response.TDSResponseDescriptionText
              mapper
            end
          end
        end
      end
    end
  end
end