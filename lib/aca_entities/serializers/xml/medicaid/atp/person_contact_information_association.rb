# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a relationship between a person and contact information.
          class PersonContactInformationAssociation
            include HappyMapper

            tag 'PersonContactInformationAssociation'
            namespace 'hix-core'

            has_one :begin_date, AssociationBeginDate
            has_one :end_date, AssociationEndDate
            element :is_primary_indicator, Boolean, tag: 'ContactInformationIsPrimaryIndicator', namespace: 'nc'
            has_one :contact, ContactInformation
            element :category_code, String, tag: 'ContactInformationCategoryCode', namespace: 'hix-core'

            def self.domain_to_mapper(contact_association)
              mapper = self.new
              mapper.contact = ContactInformation.domain_to_mapper(contact_association.contact)
              mapper.category_code = contact_association.category_code
              mapper.is_primary_indicator = contact_association.is_primary_indicator
              mapper
            end

            def to_hash
              {
                begin_date: begin_date&.to_hash,
                end_date: end_date&.to_hash,
                contact: contact&.to_hash,
                category_code: category_code,
                is_primary_indicator: is_primary_indicator
              }
            end
          end
        end
      end
    end
  end
end