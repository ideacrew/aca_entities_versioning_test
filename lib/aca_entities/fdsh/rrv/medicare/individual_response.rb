# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Entity for IndividualRequest
        class IndividualResponse < Dry::Struct
          attribute :PersonSSNIdentification,  Types::String.optional.meta(omittable: true)
          attribute :Insurances, Types::Array.of(Fdsh::Rrv::Medicare::Insurance).optional.meta(omittable: true)
          attribute :OrganizationResponseCode,  Types::String.optional.meta(omittable: true)
          attribute :OrganizationResponseCodeText,  Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end