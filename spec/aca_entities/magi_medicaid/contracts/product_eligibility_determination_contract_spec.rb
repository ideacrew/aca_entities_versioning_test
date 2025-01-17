# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Contracts::ProductEligibilityDeterminationContract, dbclean: :around_each do

  let(:all_params) do
    {
      is_ia_eligible: true,
      is_medicaid_chip_eligible: false,
      is_non_magi_medicaid_eligible: false,
      is_totally_ineligible: false,
      is_without_assistance: false,
      is_magi_medicaid: false,
      magi_medicaid_monthly_household_income: 6474.42,
      medicaid_household_size: 1,
      magi_medicaid_monthly_income_limit: 3760.67,
      magi_as_percentage_of_fpl: 10.0,
      magi_medicaid_category: 'parent_caretaker'
    }
  end

  let(:invalid_params) do
    all_params.merge({ is_magi_medicaid: "magi" })
  end

  context "with invalid params" do
    it "should fail validation" do
      result = subject.call(invalid_params)
      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :is_magi_medicaid => ["must be boolean"] })
    end
  end

  context "and all required and optional parameters" do
    it "should pass validation" do
      result = subject.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
