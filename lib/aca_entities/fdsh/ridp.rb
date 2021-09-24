# frozen_string_literal: true

# types
require 'aca_entities/types'
require_relative 'ridp/h139/types'

# contracts
require_relative 'ridp/h139/contracts/primary_request_contract'
require_relative 'ridp/h139/contracts/primary_response_contract'
require_relative 'ridp/h139/contracts/secondary_request_contract'
require_relative 'ridp/h139/contracts/secondary_response_contract'
require_relative 'ridp/h139/contracts/fars_request_contract'
require_relative 'ridp/h139/contracts/fars_response_contract'
require_relative 'ridp/h139/contracts/verification_metadata_type_contract'
require_relative 'ridp/h139/contracts/response_metadata_type_contract'
require_relative 'ridp/h139/contracts/person_type_contract'
require_relative 'ridp/h139/contracts/structured_address_type_contract'
require_relative 'ridp/h139/contracts/organization_type_contract'
require_relative 'ridp/h139/contracts/person_employment_association_type_contract'
require_relative 'ridp/h139/contracts/employment_info_type_contract'
require_relative 'ridp/h139/contracts/employer_info_type_contract'
require_relative 'ridp/h139/contracts/income_type_contract'
require_relative 'ridp/h139/contracts/pay_period_information_type_contract'
require_relative 'ridp/h139/contracts/annual_compensation_information_type_contract'
require_relative 'ridp/h139/contracts/annual_composition_type_contract'
require_relative 'ridp/h139/contracts/app_info_contract'
require_relative 'ridp/h139/contracts/base_compensation_info_type_contract'
require_relative 'ridp/h139/contracts/current_household_income_type_contract'
require_relative 'ridp/h139/contracts/current_income_info_type_contract'
require_relative 'ridp/h139/contracts/current_income_request_payload_type_contract'
require_relative 'ridp/h139/contracts/current_income_response_contract'
require_relative 'ridp/h139/contracts/current_income_response_payload_type_contract'

# entities
require_relative 'ridp/h139/primary_request'
require_relative 'ridp/h139/primary_response'
require_relative 'ridp/h139/secondary_request'
require_relative 'ridp/h139/secondary_response'
require_relative 'ridp/h139/fars_request'
require_relative 'ridp/h139/fars_response'
require_relative 'ridp/h139/verification_metadata_type'
require_relative 'ridp/h139/response_metadata_type'
require_relative 'ridp/h139/person_type'
require_relative 'ridp/h139/structured_address_type'
require_relative 'ridp/h139/organization_type'
require_relative 'ridp/h139/person_employment_association_type'
require_relative 'ridp/h139/employment_info_type'
require_relative 'ridp/h139/employer_info_type'
require_relative 'ridp/h139/income_type'
require_relative 'ridp/h139/pay_period_information_type'
require_relative 'ridp/h139/annual_compensation_information_type'
require_relative 'ridp/h139/annual_composition_type'
require_relative 'ridp/h139/app_info'
require_relative 'ridp/h139/base_compensation_info_type'
require_relative 'ridp/h139/current_household_income_type'
require_relative 'ridp/h139/current_income_info_type'
require_relative 'ridp/h139/current_income_request_payload_type'
require_relative 'ridp/h139/current_income_response'
require_relative 'ridp/h139/current_income_response_payload_type'

# transformers
require_relative 'ridp/h139/transformers/person_to_primary_request'

# operations
require_relative 'ridp/h139/operations/generate_primary_request_payload'

# happymapper
require 'aca_entities/serializers/xml/fdsh/ridp'