# frozen_string_literal: true

# Include the baseline contracts, entities and types of Insurance Assistance Program(Financial Assistance Application)
module AcaEntities
  module MagiMedicaid
    module Libraries
      module IapLibrary
        require 'aca_entities/types'
        require 'aca_entities/app_helper'
        require 'aca_entities/people/person_name'
        require 'aca_entities/locations/address'
        require 'aca_entities/contacts/phone_contact'
        require 'aca_entities/contacts/email_contact'
        require 'aca_entities/documents/document'
        require 'aca_entities/documents/vlp_document'
        require 'aca_entities/magi_medicaid/types'
        require 'aca_entities/magi_medicaid/applicant_reference'
        require 'aca_entities/magi_medicaid/relationship'
        require 'aca_entities/magi_medicaid/application_reference'
        require 'aca_entities/magi_medicaid/employer'
        require 'aca_entities/magi_medicaid/identifying_information'
        require 'aca_entities/magi_medicaid/demographic'
        require 'aca_entities/magi_medicaid/attestation'
        require 'aca_entities/magi_medicaid/native_american_information'
        require 'aca_entities/magi_medicaid/citizenship_immigration_status_information'
        require 'aca_entities/magi_medicaid/student'
        require 'aca_entities/magi_medicaid/pregnancy_information'
        require 'aca_entities/magi_medicaid/foster_care'
        require 'aca_entities/magi_medicaid/income'
        require 'aca_entities/magi_medicaid/benefit'
        require 'aca_entities/magi_medicaid/deduction'
        require 'aca_entities/magi_medicaid/applicant'
        require 'aca_entities/magi_medicaid/product_eligibility_determination'
        require 'aca_entities/magi_medicaid/tax_household_member'
        require 'aca_entities/magi_medicaid/tax_household'
        require 'aca_entities/magi_medicaid/application'

        require 'aca_entities/contracts/people/person_name_contract'
        require 'aca_entities/contracts/contacts/phone_contact_contract'
        require 'aca_entities/contracts/contacts/email_contact_contract'
        require 'aca_entities/contracts/documents/document_contract'
        require 'aca_entities/contracts/documents/vlp_document_contract'
        require 'aca_entities/magi_medicaid/contracts/contract'
        require 'aca_entities/magi_medicaid/contracts/applicant_reference_contract'
        require 'aca_entities/magi_medicaid/contracts/relationship_contract'
        require 'aca_entities/magi_medicaid/contracts/application_reference_contract'
        require 'aca_entities/magi_medicaid/contracts/employer_contract'
        require 'aca_entities/magi_medicaid/contracts/identifying_information_contract'
        require 'aca_entities/magi_medicaid/contracts/demographic_contract'
        require 'aca_entities/magi_medicaid/contracts/attestation_contract'
        require 'aca_entities/magi_medicaid/contracts/native_american_information_contract'
        require 'aca_entities/magi_medicaid/contracts/citizenship_immigration_status_information_contract'
        require 'aca_entities/magi_medicaid/contracts/student_contract'
        require 'aca_entities/magi_medicaid/contracts/foster_care_contract'
        require 'aca_entities/magi_medicaid/contracts/pregnancy_information_contract'
        require 'aca_entities/magi_medicaid/contracts/income_contract'
        require 'aca_entities/magi_medicaid/contracts/deduction_contract'
        require 'aca_entities/magi_medicaid/contracts/benefit_contract'
        require 'aca_entities/contracts/locations/address_contract'
        require 'aca_entities/magi_medicaid/contracts/applicant_contract'
        require 'aca_entities/magi_medicaid/contracts/product_eligibility_determination_contract'
        require 'aca_entities/magi_medicaid/contracts/tax_household_member_contract'
        require 'aca_entities/magi_medicaid/contracts/tax_household_contract'
        require 'aca_entities/magi_medicaid/contracts/application_contract'
      end
    end
  end
end