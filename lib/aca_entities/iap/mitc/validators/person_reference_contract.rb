# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      module Validators
        # Contract for PersonReference.
        class PersonReferenceContract < Dry::Validation::Contract

          params do
            required(:person_id).filled(:integer)
          end
        end
      end
    end
  end
end
