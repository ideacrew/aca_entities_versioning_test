# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for atp  Receiver information
      class Receiver < Dry::Struct
        attribute :recipient_code,                          Types::String.optional.meta(omittable: true)
        attribute :recipient_medicaid_chip_state,           Types::String.optional.meta(omittable: true)
        attribute :recipient_medicaid_chip_county,          Types::String.optional.meta(omittable: true)
      end
    end
  end
end