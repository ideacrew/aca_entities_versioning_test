# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for H36 DocumentBinary
      class DocumentBinary < Dry::Struct
        attribute :ChecksumAugmentation do
          attribute :SHA256HashValueText, AcaEntities::Types::String.meta(omittable: false)
        end
        attribute :BinarySizeValue, AcaEntities::Types::Integer.meta(omittable: false)
      end
    end
  end
end