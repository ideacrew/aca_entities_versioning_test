# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Email < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'begin_date', value: ->(_v) { Date.today } # default
          add_key 'end_date', value: ->(_v) { Date.today } # default
          map 'address', 'contact.email_id'
          add_key 'contact.mailing_address'
          add_key 'contact.telephone_number'
          map 'kind', 'category_code', memoize: true, visible: true, function: lambda { |v|
            v.capitalize
          }
          add_key 'is_primary_indicator'
        end
      end
    end
  end
end