# frozen_string_literal: true

# types
require 'aca_entities/fdsh/types'
require 'aca_entities/types'

# contracts
require_relative 'contracts/ifsv_response_code_detail_contract'
require_relative 'contracts/verification_contract'
require_relative 'contracts/dependent_verification_contract'
require_relative 'contracts/error_message_detail_contract'
require_relative 'contracts/ifsv_applicant_response_group_contract'
require_relative 'contracts/verify_household_income_bulk_response_contract'

require_relative 'contracts/complete_person_name_contract'
require_relative 'contracts/ifsv_applicant_contract'
require_relative 'contracts/ifsv_applicant_request_group_contract'
require_relative 'contracts/verify_household_income_bulk_request_contract'

# entities
require_relative 'ifsv_response_code_detail'
require_relative 'verification'
require_relative 'dependent_verification'
require_relative 'error_message_detail'
require_relative 'ifsv_applicant_response_group'
require_relative 'verify_household_income_bulk_response'

require_relative 'complete_person_name'
require_relative 'ifsv_applicant'
require_relative 'ifsv_applicant_request_group'
require_relative 'verify_household_income_bulk_request'

# operations

require_relative 'operations/create_rrv_ifsv_request'