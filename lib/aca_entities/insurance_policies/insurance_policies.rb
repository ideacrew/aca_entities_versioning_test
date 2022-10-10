# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::InsurancePolicies} Domain Model
  module InsurancePolicies
    # TODO: Add the classes for the domain in dependency order

    # Contracts
    require_relative 'contracts/contract'
    require_relative 'contracts/member_contract'
    require_relative 'contracts/insurance_product_feature_contract'
    require_relative 'contracts/insurance_product_contract'
    require_relative 'contracts/premium_schedule_contract'
    require_relative 'contracts/enrolled_member_premium_contract'
    require_relative 'contracts/health_care_practitioner_contract'
    require_relative 'contracts/primary_care_provider_contract'
    require_relative 'contracts/enrolled_member_contract'
    require_relative 'contracts/enrollment_election_contract'
    require_relative 'contracts/enrollment_contract'
    require_relative 'contracts/insurance_provider_contract'

    # Domain Model Entitities
  end
end