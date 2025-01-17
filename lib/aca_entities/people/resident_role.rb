# frozen_string_literal: true

module AcaEntities
  module People
    class ResidentRole < Dry::Struct
      include AcaEntities::Eligible::Eligible

      eligibility :ivl_osse_eligibility,
                  class_name: 'AcaEntities::People::IvlOsseEligibilities::IvlOsseEligibility'

      attribute :is_applicant,                          Types::Bool.optional.meta(omittable: false)
      attribute :is_active,                             Types::Bool.optional.meta(omittable: true)
      attribute :is_state_resident,                     Types::Bool.optional.meta(omittable: false)
      attribute :residency_determined_at,               Types::Date.optional.meta(omittable: true)
      attribute :contact_method,                        Types::String.optional.meta(omittable: true)
      attribute :language_preference,                   Types::String.optional.meta(omittable: true)

      attribute :local_residency_responses,             Types::Strict::Array.of(AcaEntities::Events::EventResponse).optional.meta(omittable: true)
      attribute :lawful_presence_determination,         AcaEntities::Determinations::LawfulPresenceDetermination.optional.meta(omittable: false)
    end
  end
end