# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/basis_for_income_contract'

RSpec.describe AcaEntities::Contracts::BasisForIncomeContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      ssa_citizenship_status: true
    }
  end

  context 'success case' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end
end
