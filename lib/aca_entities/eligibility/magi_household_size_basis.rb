# frozen_string_literal: true

module AcaEntities
  module Eligibility
    class MagiHouseholdSizeBasis < Dry::Struct

      attribute :status_code,                  Types::String.meta(omittable: false)
      attribute :status_indicator,             Types::Bool.optional.meta(omittable: true)
      attribute :inconsistency_reason,         Types::String.optional.meta(omittable: true)
      attribute :ineligibility_reason,         Types::String.optional.meta(omittable: true)
      attribute :status_determination_date,    Types::Date.optional.meta(omittable: true)
      attribute :status_source_code,           Types::String.optional.meta(omittable: true)

    end
  end
end