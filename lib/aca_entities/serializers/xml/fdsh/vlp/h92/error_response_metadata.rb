# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an ErrorResponseMetadata.
            class ErrorResponseMetadata
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'ErrorResponseMetadata'
              namespace 'vlp'

              element :ErrorResponseCode, String, tag: "ErrorResponseCode"
              element :ErrorResponseDescriptionText, String, tag: "ErrorResponseDescriptionText"
              element :ErrorTDSResponseDescriptionText, String, tag: "ErrorTDSResponseDescriptionText"

              def self.domain_to_mapper(response_metadata)
                mapper = self.new
                mapper.ErrorResponseCode = response_metadata.ErrorResponseCode
                mapper.ErrorResponseDescriptionText = response_metadata.ErrorResponseDescriptionText
                mapper.ErrorTDSResponseDescriptionText = response_metadata.ErrorTDSResponseDescriptionText

                mapper
              end
            end
          end
        end
      end
    end
  end
end