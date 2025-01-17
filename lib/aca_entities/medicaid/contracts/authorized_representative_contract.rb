# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for AuthorizedRepresentative.
      class AuthorizedRepresentativeContract < Dry::Validation::Contract

        params do
          optional(:first_name).maybe(:string)
          optional(:middle_name).maybe(:string)
          required(:last_name).filled(:string)
          optional(:suffix).maybe(:string)
          optional(:legal_name).maybe(:string)
          optional(:fein).maybe(:string)
          required(:designation_date).filled(:date)
        end

        rule(:designation_date) do
          key.failure(text: 'Designation date is invalid') if key? && value && (value <= 1912 || value.year > Date.today.year)
        end
      end
    end
  end
end
