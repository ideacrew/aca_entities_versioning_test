# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/structured_address_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::StructuredAddressContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { location_street: location_street,
      address_secondary_unit_text: "address",
      location_city_name: "Wheaton",
      location_county_name: "Montgomery",
      location_county_code: "code",
      location_state_us_postal_service_code: "ME",
      location_postal_code: "01234" }
  end

  let(:location_street) do
    { street_full_text: "123 Easy Street" }
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with unexpected parameters' do

      let(:input_params) { { cat: "meow" } }

      it { expect(subject.call(input_params)[:result]).to eq(nil) }
    end
  end

  context 'valid parameters' do
    context 'with optional parameters only' do

      before do
        @result = subject.call(optional_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq optional_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do

        result = subject.call(all_params)

        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
