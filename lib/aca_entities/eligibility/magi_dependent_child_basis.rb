# frozen_string_literal: true

module AcaEntities
  module Eligibility
    class MagiDependentChildBasis < Dry::Struct

      attribute :covered_code,          Types::String.meta(omittable: false)
      attribute :covered_indicator,     Types::Bool.optional.meta(omittable: true)
      attribute :determination_date,    Types::Date.optional.meta(omittable: true)
      attribute :ineligibility_reason,  Types::String.optional.meta(omittable: true)

    end
  end
end