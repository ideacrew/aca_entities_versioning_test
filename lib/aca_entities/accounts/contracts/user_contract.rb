# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Accounts
      # contract for Accounts user
      class UserContract < Dry::Validation::Contract
        params do
          optional(:attestations).array(AcaEntities::Attestations::AttestationContract.params)
          optional(:approved).maybe(:bool)
          optional(:email).maybe(:string)
          optional(:oim_id).maybe(:string)
          optional(:hint).maybe(:bool)
          optional(:identity_confirmed_token).maybe(:string)
          optional(:identity_final_decision_code).maybe(:string)
          optional(:identity_final_decision_transaction_id).maybe(:string)
          optional(:identity_response_code).maybe(:string)
          optional(:identity_response_description_text).maybe(:string)
          optional(:identity_verified_date).maybe(:date)
          optional(:idp_uuid).maybe(:string)
          optional(:idp_verified).maybe(:bool)
          optional(:last_portal_visited).maybe(:string)
          optional(:preferred_language).maybe(:string)
          optional(:profile_type).maybe(:string)
          optional(:roles).maybe(:array)
          optional(:timestamp).hash(TimeStampContract.params)
        end
      end
    end
  end
end
