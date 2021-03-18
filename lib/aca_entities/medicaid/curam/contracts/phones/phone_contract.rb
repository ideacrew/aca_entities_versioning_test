# frozen_string_literal: true

module Ehs
  class Phones::PhoneContract < Ehs::ApplicationContract
    params do
      required(:type).filled(:string)
      optional(:area_code).maybe(:string)
      required(:phone_number).filled(:string)
      required(:full_phone_number).filled(:string)
      required(:is_preferred).filled(:bool)
    end

    rule(:type) do
      key.failure(text: 'invalid type') if key? && value && !Types::PhoneKind.include?(value)
    end
  end
end
