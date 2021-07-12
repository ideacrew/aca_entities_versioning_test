# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for ReferralActivityStatus
      class ReferralActivityStatus < Dry::Struct
        attribute :status_code, Types::String.meta(omittable: false)
        attribute :overall_verification_status_code, Types::String.optional.meta(omittable: true)
        # attribute :valid_date_range, StatusValidDateRange.optional.meta(omittable: true)
      end
    end
  end
end
