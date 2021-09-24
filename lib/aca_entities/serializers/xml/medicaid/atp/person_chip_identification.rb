# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification assigned by a Childrens Health Insurance Program (CHIP) program to an individual.
          class PersonChipIdentification
            include HappyMapper

            tag 'CHIPIdentification'
            namespace 'hix-ee'

            element :identification_id, String, tag: 'IdentificationID', namespace: 'nc'

            def self.domain_to_mapper(chip_id)
              mapper = self.new
              mapper.identification_id = chip_id.identification_id
              mapper
            end

            def to_hash
              {
                identification_id: identification_id
              }
            end
          end
        end
      end
    end
  end
end