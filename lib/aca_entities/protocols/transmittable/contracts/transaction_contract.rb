# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmittable::Transaction} entity
        class TransactionContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).maybe(:string)
            required(:key).value(:symbol)
            optional(:title).maybe(:string)
            optional(:description).maybe(:string)
            optional(:transaction_id).maybe(:string)

            required(:process_status).value(AcaEntities::Protocols::Transmittable::Contracts::ProcessStatusContract.params)

            required(:started_at).value(:date_time)
            optional(:ended_at).maybe(:date_time)
            required(:transmittable_errors).array(AcaEntities::Protocols::Transmittable::Contracts::TransmittableErrorContract.params)

            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
            optional(:json_payload).maybe(:hash)
            optional(:xml_payload).maybe(:string)
          end
        end
      end
    end
  end
end