# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for InsurancePolicyAppliedEffectiveDateRange.
      class InsurancePolicyAppliedEffectiveDateRangeContract < Dry::Validation::Contract

        params do
          optional(:start_date).maybe(:hash)
          optional(:end_date).maybe(:hash)
        end
      end
    end
  end
end