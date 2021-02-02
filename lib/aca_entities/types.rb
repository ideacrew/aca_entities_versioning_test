# frozen_string_literal: true

require 'dry-types'

module AcaEntities

    # Extend DryTypes
  module Types
    send(:include, Dry.Types())
    send(:include, Dry::Logic)

  end
end
