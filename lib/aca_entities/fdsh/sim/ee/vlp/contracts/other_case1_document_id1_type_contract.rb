# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp OtherCase1DocumentID1Type
          class OtherCase1DocumentID1TypeContract < Dry::Validation::Contract
            params do
              required(:alienNumber).filled(:string)
              required(:docDescReq).filled(:string)
              optional(:passportCountry).maybe(Fdsh::Sim::Ee::Vlp::PassportCountryTypeContract.params)
              optional(:sevisid).maybe(:string)
              optional(:docExpirationDate).maybe(:date)
            end
          end
        end
      end
    end
  end
end