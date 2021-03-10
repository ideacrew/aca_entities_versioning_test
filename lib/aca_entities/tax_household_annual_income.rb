# frozen_string_literal: true

module AcaEntities
  class TaxHouseholdAnnualIncome < Dry::Struct

    attribute :annual_tax_household_income, Types::Float.optional.meta(omittable: true)
    attribute :tax_household_size, Types::Integer.optional.meta(omittable: true)
    attribute :computed_fpl, Types::Float.optional.meta(omittable: true)
  end
end