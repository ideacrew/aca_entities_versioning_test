# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an TransmissionMetadata.
          class TransmissionMetadata
            include HappyMapper
            register_namespace 'ns3', 'http://hix.cms.gov/0.1/hix-core'

            tag 'TransmissionMetadata'
            namespace 'ns3'

            element :TransmissionAttachmentQuantity, String, tag: 'TransmissionAttachmentQuantity', namespace: 'ns3'
            element :TransmissionSequenceID, String, tag: 'TransmissionSequenceID', namespace: 'ns3'

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.TransmissionAttachmentQuantity = request.TransmissionAttachmentQuantity
              mapper.TransmissionSequenceID = request.TransmissionSequenceID

              mapper
            end
          end
        end
      end
    end
  end
end