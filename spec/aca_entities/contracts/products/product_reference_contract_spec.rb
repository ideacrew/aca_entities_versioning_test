# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Products::ProductReferenceContract, dbclean: :after_each do

  let(:issuer_profile_reference) do
    {
      hbx_id: '1234',
      fein: '123333333',
      hbx_carrier_id: '333333',
      name: 'Delta Dental',
      abbrev: 'DDPA'
    }
  end

  let(:family_rated_premiums) do
    {
      exchange_provided_code: 'R-ME002',
      primary_enrollee: 40.5,
      primary_enrollee_one_dependent: 80.5,
      primary_enrollee_many_dependent: 159.0
    }
  end

  let(:required_params) do
    {
      hios_id: '92479DC0020002',
      name: 'Access PPO',
      active_year: 2020,
      is_dental_only: false,
      metal_level: 'gold',
      product_kind: 'health',
      benefit_market_kind: 'aca_shop',
      ehb_percent: '0.0',
      issuer_profile_reference: issuer_profile_reference,
      covers_pediatric_dental_costs: true,
      rating_method: 'Age-Based Rates',
      pediatric_dental_ehb: 0.9449,
      family_rated_premiums: family_rated_premiums
    }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :issuer_profile_reference })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(issuer_profile_reference: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be a hash')
      end
    end
  end
end
