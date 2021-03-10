# frozen_string_literal: true

module AcaEntities
  class PersonName < Dry::Struct

    attribute :first_name, Types::String
    attribute :middle_name, Types::String.optional.meta(omittable: true)
    attribute :last_name, Types::String
    attribute :name_sfx, Types::String.optional.meta(omittable: true)
    attribute :name_pfx, Types::String.optional.meta(omittable: true)
  end
end