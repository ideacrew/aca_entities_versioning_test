# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification assigned to an individual.
          class PersonIdentification
            include HappyMapper

            tag 'PersonIdentification'
            namespace 'hix-core'

            element :identification_id, String, tag: "IdentificationID", namespace: "nc"
            element :identification_category_text, String, tag: "IdentificationCategoryText", namespace: "nc"
            element :identification_jurisdiction, String, tag: "IdentificationJurisdictionISO3166Alpha3Code", namespace: "nc"

            def self.domain_to_mapper(identification)
              mapper = self.new
              mapper.identification_id = identification.identification_id
              mapper.identification_category_text = identification.identification_category_text
              mapper
            end

            def to_hash
              {
                identification_id: identification_id,
                identification_category_text: identification_category_text,
                identification_jurisdiction: identification_jurisdiction
              }
            end
          end
        end
      end
    end
  end
end