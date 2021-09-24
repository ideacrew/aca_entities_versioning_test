# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a collection of persons to be treated as a household unit under a state's Medicaid rules.
          class MedicaidHousehold
            include HappyMapper

            tag 'MedicaidHousehold'
            namespace 'hix-ee'

            # A  number of persons in a household based on a state's Medicaid rules.
            element :effective_person_quantity, Integer, tag: 'MedicaidHouseholdEffectivePersonQuantity'

            # True if a household's income is greater than the highest applicable MAGI standard for the household size; false otherwise
            element :income_above_highest_applicable_magi_standard_indicator, Boolean,
                    tag: 'MedicaidHouseholdIncomeAboveHighestApplicableMAGIStandardIndicator'

            has_many :household_member_references, HouseholdMemberReference

            element :household_size_quantity, Integer, tag: 'HouseholdSizeQuantity'

            def self.domain_to_mapper(household)
              mapper = self.new
              mapper.income_above_highest_applicable_magi_standard_indicator = household.income_above_highest_applicable_magi_standard_indicator
              if household.effective_person_quantity && !household.effective_person_quantity.blank?
                mapper.effective_person_quantity = household.effective_person_quantity
              end
              mapper.income_above_highest_applicable_magi_standard_indicator = household.income_above_highest_applicable_magi_standard_indicator
              mapper.household_member_references = household.household_member_references.map { |hmr| HouseholdMemberReference.domain_to_mapper(hmr) }
              mapper.household_size_quantity = household.household_size_quantity
              mapper
            end

            def to_hash
              {
                effective_person_quantity: effective_person_quantity,
                income_above_highest_applicable_magi_standard_indicator: income_above_highest_applicable_magi_standard_indicator,
                household_member_references: household_member_references,
                household_size_quantity: household_size_quantity
              }
            end
          end
        end
      end
    end
  end
end